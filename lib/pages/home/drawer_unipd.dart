import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_config.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/controllers/version_controller.dart';
import 'package:unipd_mobile/utils/utils.dart';


class DrawerUnipd extends StatelessWidget {
  const DrawerUnipd({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
      
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.onPrimary
              ),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Text('Tirocinio SFP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    
                    GetBuilder<AuthController>(
                      builder: (ctrl) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text(ctrl.user?.email ?? '', 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),

                    const Spacer(),

                    GetBuilder<VersionController>(
                      builder: (ctrl){

                        if(ctrl.isInitialized){
                          return Text('v${ctrl.version} (${ctrl.buildNumber})', style: TextStyle(color: Colors.white, letterSpacing: 1 ),);
                        }

                        return const SizedBox();
                      },
                    ),
                    
                  ],
                ),
              ),
            ),

            // ListTile(
            //   leading: Icon(Icons.move_down),
            //   title: Text('Archivio'),
            //   onTap: () {
            //     Utils.showToast(isWarning: true,
            //       text: 'Non ancora disponibile',
            //     );
            //   },
            // ),

            // ListTile(
            //   leading: Icon(Icons.language_outlined),
            //   title: Text('Erasums'),
            //   onTap: () {
            //     Utils.showToast(isWarning: true,
            //       text: 'Non ancora disponibile',
            //     );
            //   },
            // ),

            // ListTile(
            //   leading: Icon(Icons.supervisor_account_outlined),
            //   title: Text('Studente lavoratore'),
            //   onTap: () {
            //     Utils.showToast(isWarning: true,
            //       text: 'Non ancora disponibile',
            //     );
            //   },
            // ),

            const Divider(),

            ListTile(
              leading: Icon(Icons.policy),
              title: Text('Regolamento'),
              onTap: () {
                Utils.openUrl(AppConfig.REGOLAMENTO);
              },
            ),

            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Privacy'),
              onTap: () {
                Utils.openUrl(AppConfig.PRIVACY);
              },
            ),
            
            const Divider(),

            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Esci'),
              onTap: () {
                AuthController.to.logout();
              },
            ),
      
            
          ]
        ),
      ),
    );
  }
}