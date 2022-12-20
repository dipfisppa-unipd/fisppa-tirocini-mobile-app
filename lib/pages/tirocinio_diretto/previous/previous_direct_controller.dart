import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/repo/direct_internship_repo.dart';
import 'package:unipd_mobile/utils/utils.dart';


class PreviousDirectController extends GetxController {

  static PreviousDirectController get to => Get.find();

  bool isDone = false;
  bool isInstituteNotAvailable = false;
  final noteCtrl = TextEditingController();
  List<DirectInternshipChoice> choices = [];

  @override
  void onClose() {
    noteCtrl.dispose();
    super.onClose();
  }

  void toggleInstituteNotAvailable(bool v){
    isInstituteNotAvailable = v;
    update();
  }

  /// It is used to get back choices from the DirectInternshipController
  /// 
  void storeChoices(List<DirectInternshipChoice> institutes){
    choices.clear();
    choices.addAll(institutes);
    update();
  }

  void clearChoices(){
    choices.clear();
    update();
  }

  /// This will call the API to save confirmed choices remotely
  /// 
  void savePreviousChoices() async {
    if(choices.isEmpty && (!isInstituteNotAvailable || noteCtrl.text.isEmpty)){
      Utils.showToast(isWarning: true, 
        text: 'Scegliere un istituto o selezionare "non disponibile" e indicarlo nelle note'
      );
      return;
    }

    DirectInternshipRepo repo = DirectInternshipRepo();
    var career = Get.find<CareerController>();
    var res = await repo.savePreviousChoices(
        career.currentCourseYear, // TODO : è l'anno in cui viene svolto il tirocinio, che solo in questo caso coincide con quello attuale in quanto sto salvando lo storico SOLO dell'anno in corso
        career.currentDirectInternshipYear, 
        career.currentYear, 
        choices.isNotEmpty ? choices.first : null, 
        noteCtrl.text);

    if(res){
      Utils.showToast(text: 'Dati salvati');
      career.reload();
      Get.back();
      Get.back();
    }else{
      Utils.showToast(text: 'Errore di salvataggio', isError: true);
      Get.back();
    }
  }
  
}