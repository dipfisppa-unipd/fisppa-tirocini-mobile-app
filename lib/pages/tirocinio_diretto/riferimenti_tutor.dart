import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class RiferimentiTutor extends StatelessWidget {
  RiferimentiTutor({ Key? key }) : super(key: key);

  final ctrl = Get.put(DirectInternshipController());
  InstituteModel i = InstituteModel(name: "Istituto comprensivo Rosmini", address: "Via Francesco Dorighello, 16, 35128", id: "10", latitude: 0, longitude: 0, schoolType: "NORMALE");
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectInternshipController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tirocinio diretto"),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 35),
                  child: Text("Istituti di riferimento per Tirocinio Diretto", style: AppStyles.titolo,),
                ),

                YellowInfoBox(
                  message: 'Ti è stato assegnato l\'Istituto per il tirocinio Diretto in base alle preferenze che hai espresso. Ora completa i dati inserendo i riferimenti del tuo Tutor',
                ),
                
                const SizedBox(height: 40,),
          
                WhiteBox(
                  children: [
                    // ctrl.choices.isNotEmpty ? TileIstituto(istituto: ctrl.choices[0].istituto1, withTrailing: false, toggable: false,) : TileIstituto(istituto: i, withTrailing: false, toggable: false,),
                    const SizedBox(height: 55,),
                    const Text("Riferimenti del Tutor", style: AppStyles.titolo,),
                    Form(
                      key: _formKey,
                      child:Column(
                        children: [


                          // SizedBox(
                          //   width: Get.width - 36,
                          //   child: TextFormField(
                          //     controller: ctrl.nomeCtrl, 
                          //     validator: (s){
                          //       if(s==null || s.isEmpty) return 'Nome obbligatorio';
                          //       return '';
                          //     },
                          //     decoration: const InputDecoration(
                          //       label: Text('Nome'),
                          //     )
                          //   ),
                          // ),
                          // const SizedBox(height: 10,),

                          // SizedBox(
                          //   width: Get.width - 36,
                          //   child: TextFormField(
                          //     controller: ctrl.cognomeCtrl, 
                          //     validator: (s){
                          //       if(s==null || s.isEmpty) return 'Cognome obbligatorio';
                          //       return '';
                          //     },
                          //     decoration: const InputDecoration(
                          //       label: Text('Cognome'),
                          //     )
                          //   ),
                          // ),

                          // const SizedBox(height: 10,),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       width: 150,
                          //       child: TextFormField(
                          //         controller: ctrl.emailCtrl, 
                          //         validator: (s){
                          //           if(s==null || s.isEmpty) return 'Email obbligatoria';
                          //           return '';
                          //         },
                          //         decoration: const InputDecoration(
                          //           label: Text('Indirizzo email'),
                          //         )
                          //       ),
                          //     ),
                                
                          //     SizedBox(
                          //       width: 150,
                          //       child: TextFormField(
                          //         controller: ctrl.telefonoCtrl, 
                          //         validator: (s){
                          //           if(s==null || s.isEmpty) return 'Telefono obbligatorio';
                          //           return '';
                          //         },
                          //         decoration: const InputDecoration(
                          //           label: Text('Telefono'),
                          //         )
                          //       ),
                          //     ),
                          //   ],
                          // ),


                          const SizedBox(height: 10,),

                          SizedBox(
                            width: Get.width - 36,
                            child: TextFormField(
                              controller: ctrl.noteCtrl, 
                              maxLines: 3,
                              decoration: const InputDecoration(
                                label: Text('Note'),
                                hintText: "Indica gli orari di ricevimento"
                              )
                            ),
                          ),
                        ],
                      ) 
                    )
                  ], 
                  withPadding: true
                ),

                /* ctrl.scelte[0].istituto2 != null ? WhiteBox(
                  children: [
                    ctrl.scelte.isNotEmpty ? TileIstituto(istituto: ctrl.scelte[0].istituto2, withTrailing: false, toggable: false,) : TileIstituto(istituto: i, withTrailing: false, toggable: false,),
                    const SizedBox(height: 55,),
                    const Text("Riferimenti del Tutor", style: AppStyles.titolo,),
                    Form(
                      key: _formKey2,
                      child:Column(
                        children: [

                          SizedBox(
                            width: Get.width - 36,
                            child: TextFormField(
                              controller: ctrl.nomeCtrl2, 
                              validator: (s){
                                if(s==null || s.isEmpty) return 'Nome obbligatorio';
                              },
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              )
                            ),
                          ),
                          const SizedBox(height: 10,),

                          SizedBox(
                            width: Get.width - 36,
                            child: TextFormField(
                              controller: ctrl.cognomeCtrl2, 
                              validator: (s){
                                if(s==null || s.isEmpty) return 'Cognome obbligatorio';
                              },
                              decoration: const InputDecoration(
                                label: Text('Cognome'),
                              )
                            ),
                          ),

                          const SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: ctrl.emailCtrl2, 
                                  validator: (s){
                                    if(s==null || s.isEmpty) return 'Email obbligatoria';
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('Indirizzo email'),
                                  )
                                ),
                              ),
                                
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: ctrl.telefonoCtrl2, 
                                  validator: (s){
                                    if(s==null || s.isEmpty) return 'Telefono obbligatorio';
                                  },
                                  decoration: const InputDecoration(
                                    label: Text('Telefono'),
                                  )
                                ),
                              ),
                            ],
                          ),


                          const SizedBox(height: 10,),

                          SizedBox(
                            width: Get.width - 36,
                            child: TextFormField(
                              controller: ctrl.noteCtrl2, 
                              maxLines: 3,
                              decoration: const InputDecoration(
                                label: Text('Note'),
                                hintText: "Indica gli orari di ricevimento"
                              )
                            ),
                          ),
                        ],
                      ) 
                    )
                  ], 
                  withPadding: true
                ) : SizedBox()
           */
              ],
            ),
          ),

          bottomNavigationBar: BottomAppBar(
            color: AppColors.secondary, 
            child: TextButton(
              onPressed: () => {
                _formKey.currentState!.validate() ?
                {Get.back(), Utils.showToast(text: "Dati salvati correttamente")} : null,
                if(ctrl.choices[0].istituto2 != null) {
                  _formKey2.currentState!.validate() ?
                  {Get.back(), Utils.showToast(text: "Dati salvati correttamente")} : null,
                }
              },
              child: const Text(
                "SALVA", 
                style: TextStyle(
                  color: AppColors.onSecondary, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              )
            )
          ),
        );
      }
    );
  }
}