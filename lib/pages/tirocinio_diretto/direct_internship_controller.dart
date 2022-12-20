import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/models/direct/direct_choices_model.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_choices.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/scelta_istituti_step2.dart';
import 'package:unipd_mobile/repo/direct_internship_repo.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/widgets/alert_box.dart';

import '../../models/direct/institute_tutor_model.dart';

class DirectInternshipController extends GetxController{

  static DirectInternshipController get to => Get.find();
  
  final _repo = DirectInternshipRepo();

  
  final noteCtrl = TextEditingController();  
  final paramRicerca = TextEditingController();

  List<InstituteModel> _allInsitutes = [];
  List<InstituteModel> _searchInstitutes = [];
  List<InstituteModel> foundInstitutes = [];
  List<InstituteModel> _comprensivi = [];
  List<InstituteModel> _primarieParitarie = [];
  List<InstituteModel> _infanziaParitarie = [];

  InstituteModel? risultato;
  List<InstituteModel>? finalChoices;
  List<DirectInternshipChoice> choices = [];
  bool isLoading = true;
  bool isDone = false; // used to identify if the choices have been sent already
  bool showInfanziaOnly = false;
  DateTime? lastUpdate;

  List<DirectChoicesModel> directInternships = [];
  bool isConfirmed = false; // used to identify when the student's choice has been confirmed
  bool hasTutors = false; // used when the student must send tutor's data yet

  @override
  void onInit() {
    getChoices();
    super.onInit();
  }

  

  void searchIstituti({bool onlyInfancy=false}) async {

    if(showInfanziaOnly)
      onlyInfancy = showInfanziaOnly;

    print(onlyInfancy);

    if(paramRicerca.text.isEmpty){
      Utils.showToast(isWarning: true, text: 'Inserire un parametro di ricerca');
      return;
    }
    isLoading = true;
    foundInstitutes.clear();
    update();

    _searchInstitutes.clear();
    _searchInstitutes = await _repo.getInstitutes(param: paramRicerca.text);

    // Now I need to cycle found instituttes and show only desired results
    for(var institute in _searchInstitutes){
      // print('----------------');
      // print('${institute.schoolType}');
      // print('----------------');

      if(institute.isPrimariaParitaria && !onlyInfancy){
        foundInstitutes.add(institute);
      }else if(onlyInfancy && institute.isInfanziaParitaria){
        foundInstitutes.add(institute);
      }else{
        var i =_allInsitutes.firstWhereOrNull((element) => element.code == institute.referenceInstituteCode);
      
        if(i!=null && instituteIsNotInList(institute))
          foundInstitutes.add(i);
      }
      
    }
    
    isLoading = false;
    update();
  }

  bool instituteIsNotInList(InstituteModel i){
    return foundInstitutes.firstWhereOrNull((element) => element.code==i.referenceInstituteCode)==null;
  }

  void regroupIstituti() {
    
    _comprensivi.clear();
    _primarieParitarie.clear();
    _infanziaParitarie.clear();

    _comprensivi = _allInsitutes.where((element) => element.educationDegree == "ISTITUTO COMPRENSIVO").toList();

    for(var c in _comprensivi){
      var schools = _allInsitutes.where((element) => element.referenceInstituteCode == c.code).toList();
      c.schools.addAll(schools);
      
    }

    getParitarie();
  }

  void getParitarie() {
    var paritarie = _allInsitutes.where((element) => element.schoolType == "PARITARIA").toList();

    _primarieParitarie = paritarie.where((element) => element.educationDegree == "SCUOLA PRIMARIA NON STATALE").toList();
    _infanziaParitarie = paritarie.where((element) => element.educationDegree == "SCUOLA INFANZIA NON STATALE").toList();
  }


  void tapToggle(InstituteModel istituto) {
    DirectInternshipChoice scelta = DirectInternshipChoice(istituto1: istituto); 

    if(choices.isEmpty) {
      choices.add(scelta);
      if(!scelta.istituto1.isComprensivoConInfanzia())
        _generateAlert();
    } else {
      int i = choices.indexWhere((element) => element.istituto1.id == istituto.id );
      if(i > -1){
        choices.removeAt(i);
      } else if(choices.length < 3){
        choices.add(scelta);
        if(!scelta.istituto1.isComprensivoConInfanzia())
          _generateAlert();
      } else if(choices.length >= 3){
        Utils.showToast(text: 'Devi prima rimuovere una delle scelte', isWarning: true);
      }
    }

    update();
  }

  ClipOval? generateTrailing(InstituteModel istituto){
    DirectInternshipChoice scelta = DirectInternshipChoice(istituto1: istituto); 
    ClipOval? trailing;
       if(choices.contains(scelta)){
       trailing = ClipOval(
         child: Container(
           height: 40,
           width: 40,
           color: AppColors.secondary,
           child: Center(child: Text((choices.indexOf(scelta)+1).toString(), style: const TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold))),
         ),
       );
      return trailing;
     }else {
       return null;
     }
  }

  /// For student of currently 2nd and 3rd year, we do not need to check infancy
  /// then the second step will be skipped
  void checkPrimaryOnly(){
    
    // For student of currently 2nd and 3rd year, we do not need to check infancy
    if(CareerController.to.currentDirectInternshipYear>=2){
       Get.to(() => DirectInternshipChoices());
       return;
    }

    bool found = false;
    for(DirectInternshipChoice s in choices){
      if(!s.isComplete){
        Get.to(() => SceltaIstitutiStep2(scelta: choices, index: choices.indexOf(s),), preventDuplicates: false);
        searchIstituti(onlyInfancy: true);
        found = true;
        break;
      } 
    }
    if(!found)
      Get.to(() => DirectInternshipChoices());
  }


  void tapToggleStep2(InstituteModel istituto, int index) {
    print(istituto.name);
    print(index);
    print('-----');
    choices[index].istituto2 = istituto;
    print(choices[index].istituto2!.name);
    
    update();
  }

  ClipOval? generateTrailingStep2(InstituteModel istituto){
    ClipOval? trailing;
    for(DirectInternshipChoice s in choices){
       if(s.istituto2 == istituto){
        trailing = ClipOval(
          child: Container(
            height: 40,
            width: 40,
            color: AppColors.secondary,
            child: const Center(child: Icon(Icons.check, color: AppColors.onSecondary,))
          ),
        );
      }
    }

    return trailing;
  }

  bool isChecked(InstituteModel i){
    return choices.firstWhereOrNull((element) => element.istituto1==i || element.istituto2==i)!=null;
  }

  void _generateAlert() {
    if(CareerController.to.isPrimaryInfancyRequired)
    Get.dialog(
      AlertBox(
        children: [
          Text("L'istituto scelto non ha una scuola dell'infanzia. Puoi cambiare istituto o selezionare una scuola paritaria dell'infanzia nello step successivo.", 
            style: TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary))], 
            onTap: () {
              Get.back();
              FocusScope.of(Get.context!).requestFocus(FocusNode());
            }
          ),
      );
  }

  void sendChoices() async {
    if(choices.length<3 && noteCtrl.text.isEmpty){
      Utils.showToast(
        isWarning: true,
        text: 'Le note sono obbligatorie se meno di 3 scelte'
      );
      return;
    }

    List<List<String>> postData = [];
    
    for(var s in choices){
      if(s.istituto2==null){
        postData.add([s.istituto1.code!]);
      } else {
        postData.add([s.istituto1.code!, s.istituto2!.code!]);
      }
    }
    
    isDone = await _repo.saveChoices(
        CareerController.to.currentDirectInternshipYear+1, 
        postData, 
        noteCtrl.text, );
  
    if(isDone){
      lastUpdate = DateTime.now();
      Utils.showToast(text: 'Salvataggio effettuato');
      update();
    }else
      Utils.showToast(text: 'Errore di salvataggio', isError: true);

    update();
  }

  // init
  void getChoices() async {
    
    int nextInternshipCalendarYear = DateTime.now().year+1; // TODO forse sarebbe corretto rivedere l'anno accademico? vedi CalendarController

    directInternships = await _repo.getChoices();
    // res.removeAt(0); // MOCK

    if(directInternships.isNotEmpty){
      
      if(directInternships.first.calendarYear!=nextInternshipCalendarYear){
        
        isDone = false;

      }else{
        
        isConfirmed = directInternships.first.isAssignedChoiceConfirmed??false;
        hasTutors = directInternships.first.instituteTutor.isNotEmpty;

        if(hasTutors){
          _initTutors(directInternships.first.instituteTutor);
        }

        lastUpdate = directInternships.first.updatedAt;
        noteCtrl.text = directInternships.first.notes ?? '';

        for(var f in directInternships.first.enhancedChoices!){

          DirectInternshipChoice c = DirectInternshipChoice(istituto1: f.first);
          if(f.length>1)
            c.istituto2 = f[1];

          choices.add(c);
        }

        isDone = choices.length>1 || noteCtrl.text.isNotEmpty;

      }
    }
      
    if(!isDone){
      _allInsitutes = await _repo.getInstitutes(param: '');
      regroupIstituti();
    }
    
    isLoading = false;
    update();
    
  }

  /// Previous years
  void setAsPreviousChoice(InstituteModel institute){
    DirectInternshipChoice choice = DirectInternshipChoice(istituto1: institute); 

    if(choices.isEmpty) {
      choices.add(choice);
      if(!choice.istituto1.isComprensivoConInfanzia())
        _previousYearsAlert();
    } else {
      var i = choices.first;
      
      // same institute, then
      if(i.istituto1==institute) 
        choices.clear();
      // again a primary institue
      else if(institute.isComprensivo || institute.isPrimaria || institute.isPrimariaParitaria){
        choices.clear();
        if(!choice.istituto1.isComprensivoConInfanzia())
          _previousYearsAlert();
        choices.add(choice);
      // then we want to add an infancy school
      }else if(institute.isInfanzia || institute.isInfanziaParitaria){
        i.istituto2 = institute;
      }

    }

    update();
  }

  void _previousYearsAlert(){
    if(CareerController.to.currentDirectInternshipYear <= 2)
    Utils.alertBox(
      buttonText: 'OK',
      message: 'Hai selezionato un istituto senza infanzia. Ricordati di aggiungere anche la scuola dell\'infanzia.',
      onTap: Get.back
    );
  }

  void setOnlyInfancy(bool v){
    // if(choices.isEmpty && CareerController.to.currentDirectInternshipYear <= 2){
    //   Utils.showToast(isWarning: true, text: 'Seleziona prima la scuola primaria o istituto comprensivo');
    //   return;
    // }
    showInfanziaOnly = v;
    if(paramRicerca.text.isNotEmpty) searchIstituti(onlyInfancy: v);
    update();
  }

  /// Tutors
  final tut1CognomeCtrl = TextEditingController();
  final tut1NomeCtrl = TextEditingController();
  final tut1EmailCtrl = TextEditingController();
  final tut1CelCtrl = TextEditingController();
  final tut1NoteCtrl = TextEditingController();

  bool tut1isPrimary = true;
  bool tut2isPrimary = true;

  final tut2CognomeCtrl = TextEditingController();
  final tut2NomeCtrl = TextEditingController();
  final tut2EmailCtrl = TextEditingController();
  final tut2CelCtrl = TextEditingController();
  final tut2NoteCtrl = TextEditingController();

  void _initTutors(List<InstituteTutor> tutors){

    tut1CognomeCtrl.text = tutors.first.lastName ?? '';
    tut1NomeCtrl.text = tutors.first.firstName ?? '';
    tut1EmailCtrl.text = tutors.first.email ?? '';
    tut1CelCtrl.text = tutors.first.phoneNumber ?? '';
    tut1NoteCtrl.text = tutors.first.notes ?? '';
    tut1isPrimary = tutors.first.isPrimary;

    if(tutors.length>1){
      tut2CognomeCtrl.text = tutors.elementAt(1).lastName ?? '';
      tut2NomeCtrl.text = tutors.elementAt(1).firstName ?? '';
      tut2EmailCtrl.text = tutors.elementAt(1).email ?? '';
      tut2CelCtrl.text = tutors.elementAt(1).phoneNumber ?? '';
      tut2NoteCtrl.text = tutors.elementAt(1).notes ?? '';
      tut2isPrimary = tutors.elementAt(1).isPrimary;
    }

  }

  void changeIsPrimary({bool? tut1, bool? tut2}){
    if(tut1!=null){
      tut1isPrimary = tut1;
    }

    if(tut2!=null){
      tut2isPrimary = tut2;
    }

    update();
  }

  void saveTutors() async {
    if(directInternships.first.enhancedAssignedChoices==null 
      || directInternships.first.enhancedAssignedChoices!.isEmpty
      || directInternships.first.id == null) {
      
      Utils.showToast(isError: true, text: 'Errore di salvataggio');
      return;
    }

    List<InstituteTutor> tutors = [];

    if(tut1NomeCtrl.text.isEmpty){
      Utils.showToast(isWarning: true, text: 'Nome tutor 1 obbligatorio');
      return;
    }
    if(tut1CognomeCtrl.text.isEmpty){
      Utils.showToast(isWarning: true, text: 'Cognome tutor 1 obbligatorio');
      return;
    }
    if(tut1EmailCtrl.text.isEmpty){
      Utils.showToast(isWarning: true, text: 'Email tutor 1 obbligatoria');
      return;
    }
      

    // Tutor 1
    var tut1 = InstituteTutor(
      lastName: tut1CognomeCtrl.text,
      firstName: tut1NomeCtrl.text,
      phoneNumber: tut1CelCtrl.text,
      email: tut1EmailCtrl.text,
      isPrimary: tut1isPrimary,
      notes: tut1NoteCtrl.text,
      schoolCode: ''
    );

    tutors.add(tut1);

    // Tutor 2
    if(directInternships.first.enhancedAssignedChoices!.length>1
      && tut2CognomeCtrl.text.isNotEmpty
      && tut2NomeCtrl.text.isNotEmpty
      && tut2EmailCtrl.text.isNotEmpty
    ){
      var tut2 = InstituteTutor(
        lastName: tut2CognomeCtrl.text,
        firstName: tut2NomeCtrl.text,
        phoneNumber: tut2CelCtrl.text,
        email: tut2EmailCtrl.text,
        isPrimary: tut2isPrimary,
        notes: tut2NoteCtrl.text,
        schoolCode: ''
      );
      tutors.add(tut2);
      
    }else if(directInternships.first.enhancedAssignedChoices!.length>1 && (
      tut2NomeCtrl.text.isNotEmpty
      || tut2CognomeCtrl.text.isNotEmpty
      || tut2EmailCtrl.text.isNotEmpty
      )
      ){
      if(tut2NomeCtrl.text.isEmpty)
        Utils.showToast(isWarning: true, text: 'Nome tutor 2 obbligatorio');
      if(tut2CognomeCtrl.text.isEmpty)
        Utils.showToast(isWarning: true, text: 'Cognome tutor 2 obbligatorio');
      if(tut2EmailCtrl.text.isEmpty)
        Utils.showToast(isWarning: true, text: 'Email tutor 2 obbligatoria');
      return;
    }

    var res = await _repo.saveTutors(directInternships.first.id!, tutors);

    if(res) Utils.showToast(text: 'Salvato');
    else Utils.showToast(isError: true, text: 'Errore di salvataggio');
  }


  // Happy ending
  @override
  void onClose() {
    noteCtrl.dispose();
    tut1CognomeCtrl.dispose();
    tut1NomeCtrl.dispose();
    tut1EmailCtrl.dispose();
    tut1CelCtrl.dispose();
    tut1NoteCtrl.dispose();

    tut2CognomeCtrl.dispose();
    tut2NomeCtrl.dispose();
    tut2EmailCtrl.dispose();
    tut2CelCtrl.dispose();
    tut2NoteCtrl.dispose();
    super.onClose();
  }
}