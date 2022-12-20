import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/controllers/calendar_controller.dart';
import 'package:unipd_mobile/models/indirect/group_model.dart';
import 'package:unipd_mobile/models/indirect/indirect_choices_model.dart';
import 'package:unipd_mobile/models/indirect/territoriality_model.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/home/home_page.dart';
import 'package:unipd_mobile/repo/indirect_internship_repo.dart';
import 'package:unipd_mobile/utils/utils.dart';


class IndirectInternshipController extends GetxController{

  final _repo = IndirectInternshipRepo();

  bool isLoading = true;
  List<Territoriality> territorialities = [];
  List<Territoriality> choices = [];
  List<IndirectChoicesModel> finalChoices = [];
  bool isDone = false;
  bool showConfirmCurrentInternship = false;
  DateTime? lastUpdate;
  final noteCtrl = TextEditingController();  

  @override
  void onInit() {
    
    getTerritorialities();
    _getIndirectInternships(nextYear: !CalendarController.to.isNextYearSubsClosed);
    super.onInit();
  }

  @override
  void onClose() {
    noteCtrl.dispose();
    super.onClose();
  }
  

  void tapToggle(Territoriality gruppo) {

    if(choices.isEmpty) {
      choices.add(gruppo);
    } else {
      int i = choices.indexWhere((element) => element.id == gruppo.id );
      if(i > -1){
        choices.removeAt(i);
      } else if(choices.length < 3){
        choices.add(gruppo);
      } else if(choices.length >= 3){
        Utils.showToast(text: 'Devi prima rimuovere una delle scelte', isWarning: true);
      }
    }

    update();
  }

  Widget generateTrailing(Territoriality gruppo){
    
    if(choices.contains(gruppo)){
       return  CircleAvatar(
         backgroundColor: AppColors.onPrimary,
         radius: 22,
         child: Center(child: Text((choices.indexOf(gruppo)+1).toString(), style: const TextStyle(color: AppColors.onSecondary, fontSize: 16, fontWeight: FontWeight.bold))),
       );
       
      
     }else {
       return SizedBox();
     }
  }

  void getTerritorialities() async {
    territorialities = await _repo.getTerritorialities();
    update();
  }

  String getTerritorilityName(String id){
    var terr = territorialities.firstWhereOrNull((element) => element.id==id);

    return terr?.label ?? '';
  }

  /// Retrieves the choices sent for the next year
  void _getIndirectInternships({bool nextYear=false}) async {

    int year = nextYear ? CalendarController.to.nextYear : CalendarController.to.currentYear;

    finalChoices = await _repo.getChoices();
    // finalChoices.clear(); // MOCK

    if(finalChoices.isNotEmpty && finalChoices.first.calendarYear==year){
      lastUpdate = finalChoices.first.updatedAt;
      noteCtrl.text = finalChoices.first.notes ?? '';
      MissLog.i('Final choices found...');
      choices.addAll(finalChoices.first.enhancedChoices);
      isDone = true;

    } else if(finalChoices.isNotEmpty){
      // check previous assigned group
      showConfirmCurrentInternship = finalChoices.first.enhancedAssignedChoice!=null;
    }
    
    isLoading = false;
    update();

  }

  void saveChoices() async { 
    if(choices.length!=3){
      Utils.showToast(
        isWarning: true,
        text: 'Devi scegliere 3 territorialità'
      );
      return;
    }

    List<String> choicesIds = [];
    for(var c in choices)
      if(c.id!=null){
        choicesIds.add(c.id!);
      }else{
        Utils.showToast(isError: true, text: 'Errore, una delle tue scelte non è valida');
        return;
      }

    isDone = await _repo.saveChoices(
      CareerController.to.currentIndirectInternshipYear+1, // next year
      choicesIds,
      noteCtrl.text, );

    if(isDone){
      lastUpdate = DateTime.now();
      Get.back();
      Utils.showToast(text: 'Salvataggio effettuato');
      update();
    }else
      Utils.showToast(text: 'Errore di salvataggio', isError: true);

  }

  void confirmCurrentGroup() async {
    var i = finalChoices.first.enhancedAssignedChoice;
    var res = false;

    if(i!=null && i.id!=null)
    res = await _repo.confirmGroup(
      CareerController.to.currentIndirectInternshipYear+1, // next year
      i.id!,);

    if(res){
      Get.offUntil( MaterialPageRoute( builder: (context) => HomePage(), maintainState: false), (route) => false);
      Utils.showToast(text: 'Salvataggio effettuato');
      CareerController.to.reload();
    }else
      Utils.showToast(text: 'Errore di salvataggio', isError: true);
  }

  void changeGroup(){
    showConfirmCurrentInternship = false;
    update();
  }

  /// Check if for the next year the group has been assigned
  bool isGroupAssigned(){
    var group = getAssignedGroup();
    return group!=null;
  }

  GroupModel? getAssignedGroup() {
    int year = CalendarController.to.isNextYearSubsClosed 
      ? CalendarController.to.currentYear 
      : CalendarController.to.nextYear;

    var nextInternship = finalChoices.firstWhereOrNull((element) => element.calendarYear==year);

    return nextInternship!=null && nextInternship.isAssignedChoiceConfirmed && nextInternship.enhancedAssignedChoice!=null ? nextInternship.enhancedAssignedChoice : null;
    
  }
}