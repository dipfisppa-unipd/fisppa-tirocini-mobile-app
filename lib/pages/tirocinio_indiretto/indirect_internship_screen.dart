import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/models/indirect/territoriality_model.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_choices.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/widgets/group_tile.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class IndirectInternshipScreen extends GetView<IndirectInternshipController> {
  
  const IndirectInternshipScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndirectInternshipController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tirocinio indiretto"),
          ),

          body: WhiteBox(
            withPadding: false,
            children: [
              
              if(ctrl.showConfirmCurrentInternship)...[

                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 25),
                  child: Text("Vuoi confermare il tuo attuale gruppo di tirocinio indiretto?", 
                    style: AppStyles.titolo,
                  ),
                ),

                const YellowInfoBox(message: 'Se vuoi cambiare gruppo clicca sul pulsante sotto e seleziona 3 nuove scelte.'),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: const Text('Gruppo attuale', style: TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary),),
                ),

                GroupTile(ctrl.finalChoices.first.enhancedAssignedChoice!),

                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    onPressed: (){
                      Utils.alertBox(
                        onTap: ctrl.confirmCurrentGroup,
                        message: 'Vuoi confermare il tuo attuale gruppo di tirocinio indiretto anche per il prossimo anno?'
                      );
                    }, 
                    child: Text('CONFERMA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                  ),
                ),

                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    onPressed: (){
                      ctrl.changeGroup();
                    }, 
                    child: Text('CAMBIA GRUPPO', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    style: TextButton.styleFrom(
                      primary: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                  ),
                ),


              ],

              if(!ctrl.showConfirmCurrentInternship)...[

                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 25),
                  child: Text("Scelta Territorialità di riferimento per Tirocinio indiretto", 
                    style: AppStyles.titolo,
                  ),
                ),

                const YellowInfoBox(
                  message: 'Si prega di selezionare la prima, la seconda e la terza scelta. Tap di nuovo per annullarla.',
                ),
                
                const SizedBox(height:  20,),

                ...[      
                  for (Territoriality element in controller.territorialities)
                    _TerritorialitaListTile(element: element),

                ],

              ],
              

              const SizedBox(height: 100,)
            ]
          ),

          bottomNavigationBar: ctrl.isDone || ctrl.showConfirmCurrentInternship ? SizedBox() : BottomAppBar(
            color: AppColors.secondary, 
            child: TextButton(
              onPressed: (){
                if(ctrl.choices.length < 3){
                  Utils.showToast(text: 'Non hai effettuato tutte le scelte', isWarning: true);
                } else {
                  Get.to(()=> IndirectInternshipChoices());
                }
              }, 
              child: const Text("AVANTI", 
                style: TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
        );
      }
    );
  }
}

class _TerritorialitaListTile extends StatelessWidget {
  final Territoriality element;
  _TerritorialitaListTile({
    Key? key, required this.element,
  }) : super(key: key);

  final ctrl = Get.find<IndirectInternshipController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndirectInternshipController>(
      builder: (ctrl) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFCCCCCC)
              )
            ),
            width: Get.width,
            height: 80,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Container(
                    height: 50,
                    width: 40, 
                    color: AppColors.lightText, 
                    child: const Icon(
                      Icons.account_balance,
                      color: Colors.white,
                    )
                  )
                ),
              ),
              title: Text(element.label ?? '', style: const TextStyle(color: Colors.black, fontSize: 17),),
              trailing: ctrl.generateTrailing(element),
            ),
          ),
          onTap: () {
            ctrl.tapToggle(element);
          },
        );
      }
    );
  }
}