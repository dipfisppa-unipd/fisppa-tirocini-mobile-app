import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/widgets/white_box.dart';
import 'package:charcode/charcode.dart';

import '../../../app/app_styles.dart';
import '../../../widgets/atoms/yellow_info_box.dart';
import '../direct_internship_controller.dart';
import '../ui/institute_tile.dart';

class DirectInternshipConfirmed extends StatelessWidget {
  const DirectInternshipConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectInternshipController>(
      builder: (ctrl) {
        
        return SingleChildScrollView(
          child: WhiteBox(
            withPadding: false,
            children: [

              Container(
                width: Get.width,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: const Text("Istituti assegnati per il Tirocinio diretto", 
                  style: AppStyles.titolo,
                  textAlign: TextAlign.center,  
                ),
              ),

              // if(!ctrl.hasTutors)
              YellowInfoBox(
                message: "Adesso puoi inserire i dati del tutor scolastico, uno per ogni scuola che ti è stata confermata.",
              ),

              const SizedBox(height: 30),

              if(ctrl.directInternships.isNotEmpty)...[

                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Istituto 1', style: AppStyles.secondary20,),
                ),

                InstituteTile(
                  scelta1: ctrl.directInternships.first.enhancedAssignedChoices!.first, 
                  scelta2: null,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text('Tutti i campi con \u002A sono obbligatori.',
                          style: AppStyles.black17.bold,
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text('\u002AOrdine: ', style: AppStyles.black17,),
                           
                          Radio<bool>(
                            fillColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                            groupValue: ctrl.tut1isPrimary,
                            onChanged: (v){
                              ctrl.changeIsPrimary(tut1: v);
                            }, 
                            value: true,
                          ),
                          Text('Primaria', style: AppStyles.black14),

                          const SizedBox(width: 20),

                          Radio<bool>(
                            fillColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                            groupValue: ctrl.tut1isPrimary,
                            onChanged: (v){
                              ctrl.changeIsPrimary(tut1: v);
                            }, 
                            value: false,
                          ),
                          Text('Infanzia', style: AppStyles.black14),
                          
                        ],
                      ),

                      Text('Riferimenti Tutor', style: AppStyles.secondary20,),

                      TextFormField( 
                        controller: ctrl.tut1CognomeCtrl,
                        decoration: const InputDecoration(
                          label: Text('\u002ACognome'),
                        )
                      ),

                      TextFormField( 
                        controller: ctrl.tut1NomeCtrl,
                        decoration: const InputDecoration(
                          label: Text('\u002ANome'),
                        )
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField( 
                              controller: ctrl.tut1EmailCtrl,
                              decoration: const InputDecoration(
                                label: Text('\u002AEmail'),
                              )
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: TextFormField( 
                              controller: ctrl.tut1CelCtrl,
                              decoration: const InputDecoration(
                                label: Text('Telefono'),
                              )
                            ),
                          ),
                        ],
                      ),

                      TextFormField( 
                        maxLines: 2,
                        controller: ctrl.tut1NoteCtrl,
                        decoration: const InputDecoration(
                          label: Text('Note'),
                          hintText: 'Inserire qui gli orari del tutor, nome della scuola o altre informazioni utili',
                          hintStyle: TextStyle(fontSize: 14, color: AppColors.lightText)
                        )
                      ),
                        
                      
                    ],
                  ),
                ),

              ],
              
              const SizedBox(height: 40),

              if(ctrl.directInternships.isNotEmpty 
                && ctrl.directInternships.first.enhancedAssignedChoices!=null
                && ctrl.directInternships.first.enhancedAssignedChoices!.length>1)...[

                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Istituto 2', style: AppStyles.secondary20,),
                ),

                InstituteTile(
                  scelta1: ctrl.directInternships.first.enhancedAssignedChoices!.elementAt(1), 
                  scelta2: null,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text('Ordine: ', style: AppStyles.black17,),
                           
                          Radio<bool>(
                            fillColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                            groupValue: ctrl.tut2isPrimary,
                            onChanged: (v){
                              ctrl.changeIsPrimary(tut2: v);
                            }, 
                            value: true,
                          ),
                          Text('Primaria', style: AppStyles.black14),

                          const SizedBox(width: 20),

                          Radio<bool>(
                            fillColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                            groupValue: ctrl.tut2isPrimary,
                            onChanged: (v){
                              ctrl.changeIsPrimary(tut2: v);
                            }, 
                            value: false,
                          ),
                          Text('Infanzia', style: AppStyles.black14),
                          
                        ],
                      ),

                      Text('Riferimenti Tutor', style: AppStyles.secondary20,),

                      TextFormField( 
                        controller: ctrl.tut2CognomeCtrl,
                        decoration: const InputDecoration(
                          label: Text('Cognome'),
                        )
                      ),

                      TextFormField( 
                        controller: ctrl.tut2NomeCtrl,
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        )
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField( 
                              controller: ctrl.tut2EmailCtrl,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              )
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: TextFormField( 
                              controller: ctrl.tut2CelCtrl,
                              decoration: const InputDecoration(
                                label: Text('Telefono'),
                              )
                            ),
                          ),
                        ],
                      ),

                      TextFormField( 
                        maxLines: 2,
                        controller: ctrl.tut2NoteCtrl,
                        decoration: const InputDecoration(
                          label: Text('Note'),
                          hintText: 'Inserire qui gli orari del tutor, nome della scuola o altre informazioni utili',
                          hintStyle: TextStyle(fontSize: 14, color: AppColors.lightText)
                        )
                      ),
                        
                      
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              Container(
                color: AppColors.secondary,
                width: Get.width,
                height: 70,
                child: TextButton(
                  onPressed: () => ctrl.saveTutors(),
                  child: const Text(
                    "SALVA", 
                    style: TextStyle(
                      color: AppColors.onSecondary, 
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),

              const SizedBox(height: 30),
              
              
            ],
          ),
        );
      }
    );
  }
}