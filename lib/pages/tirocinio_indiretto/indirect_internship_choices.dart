import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/home/home_page.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/widgets/group_tile.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/alert_box.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class IndirectInternshipChoices extends GetView<IndirectInternshipController> {
  const IndirectInternshipChoices({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void showAlertDialog(BuildContext context) {
      AlertBox alert = AlertBox(
        onTap: () {
          controller.saveChoices();
        },
        children: const [
          Text("Stai per trasmettere le tue scelte all'Università, sei sicuro di voler procedere?", 
            style: TextStyle(fontSize: 22, fontFamily: 'Oswald', color: AppColors.secondary),
          ),
          
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return GetBuilder<IndirectInternshipController>(
      builder: (ctrl) {
        return WillPopScope(
          onWillPop: () async { 
            if(ctrl.isDone){
              Get.offUntil( MaterialPageRoute( builder: (context) => HomePage(), maintainState: false), (route) => false);
            }else{
              Get.back();
            }
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  if(ctrl.isDone){
                    Get.offUntil( MaterialPageRoute( builder: (context) => HomePage(), maintainState: false), (route) => false);
                  }else{
                    Get.back();
                  }
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: const Text("Tirocinio indiretto"),
            ),
        
            body: WhiteBox(
              withPadding: false,
              children: [
                

                if(ctrl.isGroupAssigned())...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text('Gruppo confermato', style: const TextStyle(fontSize: 22, fontFamily: 'Oswald', color: AppColors.secondary),),
                  ),

                  const SizedBox(height: 20),
                  
                  YellowInfoBox(
                    message: "Sei stato assegnato al gruppo",
                  ),

                  const SizedBox(height: 20),

                  GroupTileExtended(ctrl.getAssignedGroup()!,),
                  
                ],

                if(!ctrl.isGroupAssigned())...[

                  const Padding(
                    padding: EdgeInsets.fromLTRB(18, 8, 18, 20),
                    child: Text("Riepilogo scelte Territorialità di riferimento per Tirocinio indiretto", style: AppStyles.titolo,),
                  ),

                  YellowInfoBox(
                    message: ctrl.isDone ? 'Le tue scelte sono state inviate all\'università.\nUltimo aggiornamento ${Utils.formatDate(ctrl.lastUpdate ?? DateTime.now())}' : "Confermando queste scelte sarai in seguito assegnato ad uno dei gruppi selezionati.",
                  ),
          
                  const SizedBox(height:  20,),

                  if(ctrl.choices.isNotEmpty)
                  SelectionTile(numeroScelta: "Prima scelta", scelta: ctrl.choices[0].label ?? '',),
                  if(ctrl.choices.length>1)
                  SelectionTile(numeroScelta: "Seconda scelta", scelta: ctrl.choices[1].label ?? '',),
                  if(ctrl.choices.length>2)
                  SelectionTile(numeroScelta: "Terza scelta", scelta: ctrl.choices[2].label ?? '',),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text('Note', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: controller.noteCtrl, 
                      minLines: 2,
                      maxLines: 5,
                      enabled: !ctrl.isDone,
                      readOnly: ctrl.isDone,
                      decoration: const InputDecoration(
                        hintText: 'Puoi inserire qui eventuali note sul tirocinio indiretto',
                      ),
                    ),
                  ),

                ],
                

                const SizedBox(height:  50,),


              ], 
              
            ),
        
            bottomNavigationBar: ctrl.isDone ? SizedBox() : BottomAppBar(
              color: AppColors.secondary, 
              child: TextButton(
                onPressed: () => showAlertDialog(context), 
                child: const Text('FINE', style: TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        );
      }
    );
  }
}




class SelectionTile extends StatelessWidget {
  final String numeroScelta;
  final String scelta;
  const SelectionTile({
    Key? key, required this.numeroScelta, required this.scelta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 90,
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(numeroScelta, style: const TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text(scelta, style: const TextStyle(fontSize: 16),)
                  ],
                ),
                const Icon(Icons.check)
              ],
            ),

            const Divider()
          ],
        ),
      ),
    );
  }
}
