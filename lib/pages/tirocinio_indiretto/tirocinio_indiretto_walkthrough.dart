import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_choices.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_indiretto/indirect_internship_screen.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/widgets/message_box.dart';

class TirocinioIndirettoWalkThrough extends StatelessWidget {
  const TirocinioIndirettoWalkThrough({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<IndirectInternshipController>(
      builder: (ctrl) {

        if(ctrl.isLoading) return _Loading();

        if(ctrl.isDone) return IndirectInternshipChoices();

        return MessageBox(
          onTap: () => Get.to(()=>IndirectInternshipScreen(),),
          children: const [
            Text("Gestisci la tua iscrizione in maniera semplice e veloce:", style: TextStyle(color: AppColors.secondary, fontFamily: 'Oswald', fontSize: 21),),
            SizedBox(height: 15,),
            Text("Iscriviti ai tuoi tirocini in un tap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.black),),
            SizedBox(height: 20,),
            Text("Nelle schermate successive dovrai scegliere tre territori, a te più consoni, dove vorrai seguire il tuo tirocinio. Le scelte saranno intese in ordine di gradimento, dalla prima alla terza.", 
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      }
    );
  }
}


class _Loading extends StatelessWidget {
  const _Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      body: Center(child: Loader(color: Colors.white, size: 50,))
    );
  }
}