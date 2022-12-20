import 'dart:async';
// import 'dart:html' as html; // da commentare per mobile 1/2
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/app/app_routes.dart';
import 'package:unipd_mobile/models/user.dart';
import 'package:unipd_mobile/pages/shibboleth.dart';
import 'package:unipd_mobile/repo/auth_repo.dart';
import 'package:unipd_mobile/repo/secure_repo.dart';
import 'package:unipd_mobile/repo/user_repo.dart';
import 'package:unipd_mobile/services/api_service.dart';
import 'package:unipd_mobile/utils/utils.dart';


class AuthController extends GetxController with StateMixin<UserModel>{

  static AuthController get to => Get.find();

  final _authRepo = AuthRepo();
  final _userRepo = UserRepo();
  final isLoading = false.obs;

  Timer? _pollingTimer, _timeout;

  UserModel? user;
  var xWin;

  int get numOfUniversityCredits => user?.university?.earnedCreditsNumber ?? 0;
  
  @override
  void onInit() {
    Get.find<ApiService>().initApi();
    super.onInit();
  }

  @override
  void onClose() {
    cancelPolling();
    super.onClose();
  }

  void guard(){
    if(user?.id==null)
      Get.offNamed(AppRoutes.DISPATCHER);
  }

  void login() async {
    isLoading(true);

    if(SecureRepo.to.refreshToken==null || SecureRepo.to.refreshToken!.isEmpty){
      
      Utils.showToast(text: 'Accesso richiesto');
      var url = await _authRepo.initAuth();
      
      if(url!=null)
        if(GetPlatform.isWeb){
          // xWin = html.window.open(url, 'SHIB'); // da commentare per mobile 2/2
        }else{
          Get.to(()=>ShibbolethWebView(url));
        }
        
      _startPolling();
      return;
    }

    // Il refresh token è presente
    var newToken = await refreshAccessToken();

    if(newToken==null){
      Utils.showToast(isError: true, text: 'Si è verificato un errore');
      Get.offNamed(AppRoutes.LOGIN);
      isLoading(false);
      return;
    }

    Get.find<ApiService>().initApi();
    await _decodeToken(newToken);
    
  }

  void logout() async {
    await SecureRepo.to.deleteAll(); 
    user = UserModel();
    change(user, status: RxStatus.success());
    Get.offNamed(AppRoutes.LOGIN);
  }

  Future<String?> refreshAccessToken() async {
    var newAccessToken = await _authRepo.refreshToken();
    if(newAccessToken==null){
      SecureRepo.to.deleteAll();
      Get.offNamed(AppRoutes.LOGIN);
    }
      
    
    return newAccessToken;
  }


  void _startPolling(){

    _timeout = Timer.periodic(Duration(seconds: 80), (timer) {
      xWin?.close();
      cancelPolling();
      
      Get.offNamed(AppRoutes.LOGIN);
      Utils.showToast(isError: true, text: 'Tempo scaduto, riprovare');

    });

    _pollingTimer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
        var data = await _authRepo.checkAuth();
        if(data!=null){
          cancelPolling();
          xWin?.close(); 
          if(data=='unauthorized')
            Utils.showToast(text: 'Non autorizzato', isError: true);
          else 
            _decodeToken(data);

        }
    });
  }

  void cancelPolling(){
    _pollingTimer?.cancel();
    _timeout?.cancel();
    isLoading(false);
  }

  Future<void> _decodeToken(String token) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      
      if(!kReleaseMode){
        print('-------------------------------');
        print(decodedToken);
        print('-------------------------------');
        print('email: ${decodedToken['email']}');
      }

      await getUser(withEmail: decodedToken['email'] ?? '');
      isLoading(false);

      if(user!=null && (user!.email?.toLowerCase().contains('unipd') ?? false))
        Get.offNamed(AppRoutes.HOME);
      

    } on Exception catch (e) {
      MissLog.e('$e');
    }

    return;
  }

  Future<UserModel?> getUser({String withEmail=''}) async {
    user = await _userRepo.getUser();
    MissLog.i(user?.registry?.toJson() ?? 'no user...');
    if(withEmail.isNotEmpty)
      user?.email = withEmail;

    update();
    return user;
  }

  Future<void> saveUser(UserModel? u) async {
    if(u==null){
      Utils.showToast(isError: true, text: 'Dati non validi');
      return;
    }

    try {
      
      var res = await _userRepo.editUser(u);
      
      if(res==null){
        Utils.showToast(isError: true, text: 'Si è verificato un errore');
        return;
      }
      
      user = res;
      update();
      Utils.showToast(text: 'Dati salvati');
    } on Exception catch (e) {
      MissLog.e('$e');
    }

  }

}