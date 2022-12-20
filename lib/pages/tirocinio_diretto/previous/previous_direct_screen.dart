import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/previous/previous_direct_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/search/search_institute_screen.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/info_message.dart';
import 'package:unipd_mobile/widgets/tile_istituto.dart';
import 'package:unipd_mobile/widgets/white_box.dart';
import 'package:unipd_mobile/widgets/year_box.dart';


class PreviousDirectScreen extends GetView<PreviousDirectController> {
  const PreviousDirectScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tirocinio Diretto ${DateTime.now().year}"),
      ),

      body: WhiteBox(
        withPadding: false,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 8, 18, 25),
            child: Text("Istituti per Tirocinio Diretto", 
              style: AppStyles.titolo,
            ),
          ),

          const YellowInfoBox(
            message: 'Si prega di selezionare l\'istituto (o gli istituti) a cui siete attualmente assegnati per l\'anno in corso.',
          ),

          const SizedBox(height:  20,),

          GetBuilder<CareerController>(
            builder: (ctrl){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  

                  if(ctrl.currentDirectInternshipYear==0)...[
                    Center(
                      child: Text('Qual è il tuo attuale anno di tirocinio?', 
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        YearBox(1, onTap: ()=>ctrl.setInternshipYear(1),),
                        YearBox(2, onTap: ()=>ctrl.setInternshipYear(2),),
                        YearBox(3, onTap: ()=>ctrl.setInternshipYear(3),),
                      ],
                    ),

                  ],


                  if(ctrl.currentDirectInternshipYear>0)...[

                      // InkWell(
                      //   onTap: (){
                      //     // ctrl.resetCurrentInternshipYear();
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 12.0, top: 0, bottom: 25),
                      //     child: Row(
                            
                      //       children: [
                      //         Icon(Icons.arrow_back),
                      //         const SizedBox(width: 10),
                      //         Text('Scegli un altro anno di tirocinio',
                      //           style: TextStyle(fontSize: 18),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 20, 20),
                        child: Text('${ctrl.currentDirectInternshipYear} anno di tirocinio', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onPrimary),
                        ),
                      ),

                  ],

                ],
              );
            },
          ),


          GetBuilder<PreviousDirectController>(
            builder: (ctrl){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(!ctrl.isInstituteNotAvailable)...[
                    
                    if(ctrl.choices.isEmpty)
                    InkWell(
                      onTap: (){
                        Get.to(()=>SearchInstituteScreen(),
                          binding: BindingsBuilder.put(()=>DirectInternshipController())
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 0, bottom: 10),
                        child: Row(
                          
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(width: 10),
                            Text('Seleziona l\'istituto',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if(ctrl.choices.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: const Text('Istituto/i', style: TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary),),
                              ),
                              IconButton(onPressed: ctrl.clearChoices, icon: Icon(Icons.delete_forever)),
                            ],
                          ),
                          
                          
                          TileIstituto(
                            istituto: ctrl.choices.first.istituto1, 
                            withTrailing: false, 
                          ),
                          
                          if(ctrl.choices.first.istituto2 != null) 
                          TileIstituto(
                            istituto: ctrl.choices.first.istituto2, 
                            withTrailing: false, 
                          ),
                          
                        ],
                      ),
                    )
                  ],
                  
                  if(ctrl.choices.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SwitchListTile(
                      title: Text('L\' istituto non è presente in elenco', style: TextStyle(color: AppColors.lightGrey),),
                      activeColor: AppColors.onPrimary,
                      value: ctrl.isInstituteNotAvailable, 
                      onChanged: (v){
                        ctrl.toggleInstituteNotAvailable(v);
                      }
                    ),
                  ),

                  const InfoMessage(),


                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 00),
                      child: Text('Note', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: ctrl.noteCtrl, 
                        minLines: 2,
                        maxLines: 5,
                        enabled: !ctrl.isDone,
                        readOnly: ctrl.isDone,
                        decoration: const InputDecoration(
                          hintText: 'Inserisci qui eventuali note',
                        ),
                      ),
                    )
                ],
              );
            },
          ),

          const SizedBox(height: 100,)
        ]
      ),

      bottomNavigationBar: GetBuilder<PreviousDirectController>(
        builder: (ctrl){
          return ctrl.isDone ? SizedBox() : BottomAppBar(
          color: AppColors.secondary, 
          child: TextButton(
            onPressed: (){
              if(ctrl.isInstituteNotAvailable && ctrl.noteCtrl.text.isEmpty){
                Utils.showToast(isWarning: true, text: 'Inserire nelle note il nome dell\'istituto');
                return;
              }
              Utils.alertBox(
                buttonText: 'CONFERMA',
                message: 'Vuoi confermare i dati del tuo tirocinio diretto per l\'anno in corso?',
                onTap: () => ctrl.savePreviousChoices()
              );
            }, 
            child: const Text("SALVA", 
              style: TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),),
            ),
          );
        },
      ),
    );
  }
}