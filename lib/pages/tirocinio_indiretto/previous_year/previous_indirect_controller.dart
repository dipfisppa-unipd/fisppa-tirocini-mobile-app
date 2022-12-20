import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/models/indirect/group_model.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/home/home_page.dart';
import 'package:unipd_mobile/repo/indirect_internship_repo.dart';
import 'package:unipd_mobile/utils/utils.dart';


class PreviousIndirectController extends GetxController {

  final _repo = IndirectInternshipRepo();

  bool isLoading = true;
  bool isDone = false;
  final noteCtrl = TextEditingController();
  String? selectedGroup;

  List<GroupModel> groups = [];

  @override
  void onInit() {
    getGroups(CareerController.to.currentIndirectInternshipYear);
    super.onInit();
  }

  @override
  void onClose() {
    noteCtrl.dispose();
    super.onClose();
  }


  void onGroupSelected(String? id){
    selectedGroup = id;
    update();
  }

  void getGroups(int internshipYear) async {
    selectedGroup = null;
    isLoading = true;
    groups.clear();
    update();
    groups = await _repo.getGroups(internshipYear,);

    // TODO temporary fix, internshipYear è da considerarsi per il nextYear. Se voglio l'anno di internshipYear corrente => anno attuale - foundationyear
    int foundationYear = DateTime.now().year-internshipYear;
    groups.removeWhere((element) => element.foundationYear!=foundationYear);

    isLoading = false;
    update();
  } 

  void resetGroups(){
    selectedGroup = null;
    groups.clear();
    update();
  }

  void saveChoice() async {

    var selectedInternshipYear = CareerController.to.currentIndirectInternshipYear;

    if(selectedInternshipYear==0){
      Utils.showToast(isWarning: true, text: 'Non è stato selezionato l\'anno di tirocinio');
      return;
    }

    bool res = await _repo.savePreviousGroupChoice(
      selectedInternshipYear, 
      DateTime.now().year,
      CareerController.to.currentCourseYear,
      confirmedChoice: selectedGroup,
      notes: noteCtrl.text,
    );

    if(res){
      Utils.showToast(text: 'Il tirocinio è stato salvato');
      CareerController.to.reload();
      Get.offUntil( MaterialPageRoute( builder: (context) => HomePage(), maintainState: false), (route) => false);
    }else{
      Utils.showToast(isError: true, text: 'Errore durante il salvataggio');
    }

  }
  
}