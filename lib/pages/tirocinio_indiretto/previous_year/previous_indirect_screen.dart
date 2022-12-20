import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/previous_year/previous_indirect_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/widgets/group_tile.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';


class PreviousIndirectScreen extends StatelessWidget {
  const PreviousIndirectScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tirocinio indiretto ${DateTime.now().year}"),
      ),

      body: WhiteBox(
        withPadding: false,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 8, 18, 25),
            child: Text("Gruppi di riferimento per Tirocinio indiretto", 
              style: AppStyles.titolo,
            ),
          ),

          const YellowInfoBox(
            message: 'Si prega di selezionare il gruppo di tirocinio a cui siete attualmente assegnati per l\'anno in corso.',
          ),

          const SizedBox(height:  20,),

          GetBuilder<PreviousIndirectController>(
            builder: (ctrl){

              if(ctrl.isLoading)
              return Center(child: Loader(size: 50,));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // if(ctrl.groups.length>0)
                  // InkWell(
                  //   onTap: (){
                  //     ctrl.resetGroups();
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 12.0, top: 5, bottom: 20),
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

                  for(var g in ctrl.groups)
                  GroupTile(g, 
                    onTap: () => ctrl.onGroupSelected(g.id),
                    isSelected: ctrl.selectedGroup==g.id,
                  ),

                  if(ctrl.groups.isNotEmpty)...[

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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

                  if(ctrl.groups.isEmpty)...[
                    Center(
                      child: Text('Si è verificato un problema\nnessun gruppo trovato', 
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 30,),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     YearBox(1, onTap: ()=>ctrl.getGroups(1),),
                    //     YearBox(2, onTap: ()=>ctrl.getGroups(2),),
                    //     YearBox(3, onTap: ()=>ctrl.getGroups(3),),
                    //   ],
                    // ),

                  ],
                  
                ],
              );
            },
          ),
      
          const SizedBox(height: 100,)
        ]
      ),

      bottomNavigationBar: GetBuilder<PreviousIndirectController>(
        builder: (ctrl){
          return ctrl.isDone ? SizedBox() : BottomAppBar(
          color:ctrl.selectedGroup==null ? AppColors.grey : AppColors.secondary, 
          child: TextButton(
            onPressed: ctrl.selectedGroup==null ? null : (){
              Utils.alertBox(
                buttonText: 'CONFERMA',
                message: 'Sei sicuro di voler confermare il tuo attuale gruppo di tirocinio?',
                onTap: ctrl.saveChoice,
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

