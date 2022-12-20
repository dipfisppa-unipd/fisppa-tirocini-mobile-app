import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/home/home_page.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/alert_box.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

import 'confirmed/direct_internship_confirmed.dart';
import 'ui/institute_tile.dart';

class DirectInternshipChoices extends GetView<DirectInternshipController> {
  const DirectInternshipChoices({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectInternshipController>(
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
              title: const Text("Tirocinio Diretto"),
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
            ),
        
            body: ctrl.isConfirmed 
              ? DirectInternshipConfirmed()
              : WhiteBox(
              withPadding: false,
              children: [

                Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: const Text("Riepilogo scelte istituti di riferimento per Tirocinio diretto", 
                    style: AppStyles.titolo,
                    textAlign: TextAlign.center,  
                  ),
                ),

                YellowInfoBox(
                  message: ctrl.isDone 
                        ? 'Le tue scelte sono state inviate all\'università.\nUltimo aggiornamento ${Utils.formatDate(ctrl.lastUpdate ?? DateTime.now())}'
                        : "Confermando queste scelte sarai successivamente assegnato a uno o più istituti. ",
                ),

                const SizedBox(height:  20,),

                if(ctrl.choices.length<3 && !ctrl.isDone)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Attenzione, hai selezionato solo ${ctrl.choices.length} scelta/e su 3. Se non hai trovato un istituto puoi indicarlo nelle note in fondo specificando il tuo ordine di gradimento.',
                    style: TextStyle(fontWeight: FontWeight.bold,),
                  ),
                ),

                if(ctrl.choices.isNotEmpty)
                InstituteTile(numeroScelta: "Prima scelta", scelta1: ctrl.choices[0].istituto1, scelta2: ctrl.choices[0].istituto2,),
                if(ctrl.choices.length>1)
                InstituteTile(numeroScelta: "Seconda scelta", scelta1: ctrl.choices[1].istituto1, scelta2: ctrl.choices[1].istituto2,),
                if(ctrl.choices.length>2)
                InstituteTile(numeroScelta: "Terza scelta", scelta1: ctrl.choices[2].istituto1, scelta2: ctrl.choices[2].istituto2,),
                

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 00),
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
                      hintText: 'Puoi inserire qui eventuali note sul tirocinio diretto',
                    ),
                  ),
                ),

                const SizedBox(height:  50,),

              ], 
              
            ),
        
            bottomNavigationBar: 
              ctrl.isDone 
                ? SizedBox() 
                : BottomAppBar(
                  color: AppColors.secondary, 
                  child: TextButton(
                    onPressed: () => showAlertDialog(context), 
                    child: const Text('FINE', style: TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),)
                  ),
                ),
          ),
        );
      }
    );
  }

  showAlertDialog(BuildContext context) {
    AlertBox alert = AlertBox(
      onTap: (){
        controller.sendChoices();
        Get.back();
        // showAlertDialog2(context);
      }  ,
      children: const [
        Text("Stai per trasmettere le tue scelte all'Università, sei sicuro di voler procedere? Non potranno essere modificate.", 
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

}




