import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/pages/home/drawer_unipd.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/tirocinio_diretto_walkthrough.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/tirocinio_indiretto_walkthrough.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/unipd_mobile_appbar.dart';
import 'dart:io' as io;


import '../../app/app_routes.dart';
import '../../controllers/calendar_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  bool checkCreditsSaved(){
    if(AuthController.to.numOfUniversityCredits <= 0){
      Utils.alertBox(
        message: 'Completa la Registazione Tirocinante indicando il numero di crediti acquisiti.',
        buttonText: 'OK',
        onTap: Get.back
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { 
        if(!GetPlatform.isWeb)
        Utils.alertBox(
          message: 'Sei sicuro di voler chiudere l\'applicazione?',
          onTap: (){
            if(GetPlatform.isAndroid) SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            if(GetPlatform.isIOS) io.exit(0);
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 22.0, right: 10),
            //   child: Text('Ciao ${AuthController.to.user?.fullname ?? ''}', style: AppStyles.white16),
            // ),
          ],
        ),
        drawer: const DrawerUnipd(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                const SizedBox(height: 0.8,),
                
                const UnipdMobileHeader(),

                
        
                GetBuilder<CareerController>(
                  builder: (ctrl) {

                    if(ctrl.isLoading)
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: const Text('Attendere, stiamo verificando lo stato dei tirocini'),
                          ),
                        ),
                        
                        const Loader(size: 50,),
                      ],
                    );

                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          color: Color(0xffF8F8F8),
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                              
                                    GetBuilder<AuthController>(
                                      builder: (ctrl) {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(21.0, 40, 18, 0),
                                          child: Text(ctrl.user?.fullname ?? '', style: AppStyles.secondary20.bold,),
                                        );
                                      }
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(21.0, 10, 18, 6),
                                      child: Text("Anno Accademico ${CalendarController.to.currentAcademicYear}", 
                                        style: TextStyle(fontSize: 14,),
                                      ),
                                    ),
                              
                                    GetBuilder<CareerController>(
                                      builder: (ctrl) {
                                        if(ctrl.currentDirectInternshipYear>0)
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(21.0, 0, 18, 40),
                                            child: Text("Sei iscritto/a al ${ctrl.currentDirectInternshipYear} anno di tirocinio", 
                                              style: TextStyle(fontSize: 14,),
                                            ),
                                          );
                              
                                        return const SizedBox();
                                      }
                                    ),
                              
                                  ],
                                ),
                              ),

                              Image.asset('assets/images/logo.png', height: 94), 
                            ],
                          ),
                        ),
            
                        const SizedBox(height: 15),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(AppRoutes.ISCRIZIONE,);
                              
                            },
                            child: Row(
                              children: [
                                Expanded(child: Text('Anagrafica', style: AppStyles.secondary20.oswald,)),

                                const Icon(Icons.chevron_right, size: 30, color: AppColors.secondary,)
                                
                              ],
                            ),
                          ),
                        ),

                        const Divider(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
                          child: InkWell(
                            onTap: (){
                              Get.to(() => const TirocinioIndirettoWalkThrough(), 
                                binding: BindingsBuilder.put(() => IndirectInternshipController())
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(child: Text('Tirocinio Indiretto', style: AppStyles.secondary20.oswald,)),

                                const Icon(Icons.chevron_right, size: 30, color: AppColors.secondary,)
                                
                              ],
                            ),
                          ),
                        ),

                        const Divider(),

                        // Denominazione
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Text('Denominazione', style: AppStyles.black14.bold,)
                        //       ),
                        //       Expanded(child: Text('TOL A - 2022', style: AppStyles.body14,)),
                        //     ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     children: [
                        //       Expanded( child: Text('Territorialità', style: AppStyles.black14.bold,),),
                        //       Expanded( child: Text('TOL', style: AppStyles.body14,),),
                        //     ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(child: Text('Tutor Coordinatore', style: AppStyles.black14.bold,)),
                        //       Expanded(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('Sara Valdani', style: AppStyles.body14,),
                        //             Text('sara.valdani@unipd.it', style: AppStyles.body14,),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Expanded(child: Text('Tutor Organizzatore', style: AppStyles.black14.bold,)),
                        //       Expanded(
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text('Sara Valdani', style: AppStyles.body14,),
                        //             Text('sara.valdani@unipd.it', style: AppStyles.body14,),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // const Divider(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 10),
                          child: InkWell(
                            onTap: (){
                              Get.to(() => const TirocinioDirettoWalkthrough(),
                                binding: BindingsBuilder.put(() => DirectInternshipController())
                              );
                            },
                            child: Row(
                              children: [
                                Expanded(child: Text('Tirocinio Diretto', style: AppStyles.secondary20.oswald,)),

                                const Icon(Icons.chevron_right, size: 30, color: AppColors.secondary,)
                                
                              ],
                            ),
                          ),
                        ),

                        const Divider(),


                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     children: [
                        //       Expanded(child: Text('Istituto', style: AppStyles.black14.bold,)),
                        //       Expanded(child: Text('De Amicis Enna', style: AppStyles.body14,)),
                        //     ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 6),
                        //   child: Row(
                        //     children: [
                        //       Expanded(child: Text('Istituto', style: AppStyles.black14.bold,)),
                        //       Expanded(child: Text('De Amicis Enna', style: AppStyles.body14,)),
                        //     ],
                        //   ),
                        // ),

                        const SizedBox(height: 25,),
                        
                      ],
                    );
                  
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}