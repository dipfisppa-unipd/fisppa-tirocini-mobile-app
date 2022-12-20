
import 'package:get/get.dart';
import 'package:misslog/misslog.dart';
import 'package:unipd_mobile/app/app_keys.dart';
import 'package:unipd_mobile/app/app_routes.dart';
import 'package:unipd_mobile/repo/secure_repo.dart';
import 'package:unipd_mobile/services/api_service.dart';



class AuthRepo {

  final _api = Get.find<ApiService>();
  final _storage = Get.find<SecureRepo>();

  /// Ritorna l'url da chiamare per l'auth con Shibboleth
  Future<String?> initAuth() async {

    try {
      
      var data = await _api('/auth/generateLoginToken',
        method: ApiMethod.GET,
      );
      
      if(data!=null){
        
        if(data['url']==null || data['authCode']==null){
          MissLog.e('No content in url or authcode');
          return null;
        }

        _storage.saveToken(data['authCode'], AppKeys.AUTH_CODE);
        return data['url'];

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error initAuth: $e', tag: 'AuthRepo');
    }

    return null;
  }

  /// Refresh token
  /// Ritorna [403] se è scaduto o non più valido
  /// 
  Future<String?> refreshToken() async {
    
    if(_storage.refreshToken==null || _storage.refreshToken!.isEmpty) {
      Get.offNamed(AppRoutes.LOGIN);
      return null;
    }
      

    var apiRefresh = ApiService();
    apiRefresh.initApi(refreshToken: _storage.refreshToken);

    try {
      
      var data = await apiRefresh('/auth/refresh', 
        verbose: false, 
        method: ApiMethod.POST,
      );
      
      if(data!=null){
        
        if(data['accessToken']==null)
          return null;

        _storage.saveToken(data['accessToken'], AppKeys.ACCESS_TOKEN);
        return data['accessToken'];

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error refreshToken: $e', tag: 'AuthRepo');
    }

    return null;
  }

  /// Check for authorization token
  /// Ritorna [404] se non ancora loggato
  /// Ritorna [200] + accessToken e refreshToken quando OK
  /// Ritorna [403] in caso di forbidden auth, studente o dipendente non ammesso
  /// 
  Future<String?> checkAuth() async {

    try {
      
      var data = await _api('/auth',
        method: ApiMethod.POST,
        verbose: false,
        params: {
          "authCode": _storage.authCode, 
        }
      );
      
      if(data!=null && (data is! int)){
        
        if(data['accessToken']==null)
          return null;

        _storage.saveToken(data['accessToken'], AppKeys.ACCESS_TOKEN);
        _storage.saveToken(data['refreshToken'], AppKeys.REFRESH_TOKEN);
        _api.initApi();

        return data['accessToken'];

      } else if(data==403 || data==500) {
        MissLog.e("Access forbidden");
        return 'unauthorized';

      } else {
        MissLog.e("data null");
      }
      
    } catch (e) {
      MissLog.e('Error checkAuth: $e', tag: 'AuthRepo');
    }

    return null;
  }
}