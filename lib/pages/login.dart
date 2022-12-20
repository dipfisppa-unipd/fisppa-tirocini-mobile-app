import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_config.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/controllers/version_controller.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/unipd_mobile_appbar.dart';



class Login extends GetView<AuthController> {
  
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const UnipdMobileHeader(),

                  const SizedBox(height: 30,),

                  Image.asset(
                    'assets/images/logo.png',
                    height: kIsWeb ? 150 : Get.width/2.2,
                    width: kIsWeb ? 150 : Get.width/2.2,
                  ),

                  const SizedBox(height: 30,),

                  Image.asset(
                    'assets/images/sso.png',
                    height: 90,
                  ),

                  const SizedBox(height: 30,),

                  SizedBox(
                      height: 55,
                      width: 180,
                      child:  Obx(()=> controller.isLoading() 
                      ? Loader(size: 50,) 
                      : ElevatedButton(
                        onPressed: () {
                          
                          AuthController.to.login();
                          
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.secondary)),
                        child: Text("Accedi",
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 22,
                              color: AppColors.onSecondary),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15,),

                  GetBuilder<VersionController>(
                    builder: (ctrl){

                      if(ctrl.isInitialized){
                        return Text('v${ctrl.version} (${ctrl.buildNumber})', 
                          style: TextStyle(color: AppColors.onPrimary, letterSpacing: 1, fontSize: 12),
                        );
                      }

                      return const SizedBox();
                    },
                  ),

                  const Spacer(),

                  InkWell(
                    onTap: (){
                      Utils.openUrl(AppConfig.PRIVACY);
                    },
                    child: const Text(
                      "Accedendo accetti la privacy policy \ne i termini e condizioni d’uso",
                      style: TextStyle(fontSize: 12, color: AppColors.secondary),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 26,),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}
