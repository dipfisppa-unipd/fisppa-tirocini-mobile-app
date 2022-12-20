import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_routes.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/repo/secure_repo.dart';


class DispatcherController extends GetxController{

  @override
  void onInit() {
    _checkLogin();
    super.onInit();
  }

  void _checkLogin() async {

    // delay per evitare error rebuild
    await Future.delayed(Duration(seconds: 2)); 
    if(SecureRepo.to.refreshToken==null){
      Get.offNamed(AppRoutes.LOGIN);
      return;
    }

    AuthController.to.login();
  }
}