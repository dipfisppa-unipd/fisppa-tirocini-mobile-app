import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:unipd_mobile/app/app_config.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/models/user.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/utils/utils.dart';


enum ValidationType {
  email, 
  emailStudenti, 
  anagrafica
}

class IscrizioneTirocinioController extends GetxController {


  ScrollController scrollController = ScrollController();

  final anagraficaFormKey = GlobalKey<FormState>();
  final domicilioFormKey = GlobalKey<FormState>();

  final isSaving = false.obs;
  bool domDiversoRes = false;

  final nomeCtrl = TextEditingController();
  final cognomeCtrl = TextEditingController();
  final matricolaCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final emailPersonaleCtrl = TextEditingController();
  final emailIstituzionaleCtrl = TextEditingController(); 

  final viaDomCtrl = TextEditingController();
  final cittaDomCtrl = TextEditingController();
  final capDomCtrl = TextEditingController();
  final provinciaDomCtrl = TextEditingController();

  final viaResCtrl = TextEditingController();
  final cittaResCtrl = TextEditingController();
  final capResCtrl = TextEditingController();
  final provinciaResCtrl = TextEditingController();

  final creditiCtrl = TextEditingController();
  final noteCtrl = TextEditingController();

  final annoDiTirocinio = 1.obs;

  int annoDiCorso = 0;

  final readOnly = false.obs;

  final validationType = Rx<ValidationType>(ValidationType.anagrafica);

  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    nomeCtrl.dispose();
    cognomeCtrl.dispose();
    matricolaCtrl.dispose();
    telefonoCtrl.dispose();
    emailPersonaleCtrl.dispose();
    emailIstituzionaleCtrl.dispose();
    viaDomCtrl.dispose();
    cittaDomCtrl.dispose();
    capDomCtrl.dispose();
    provinciaDomCtrl.dispose();
    viaResCtrl.dispose();
    cittaResCtrl.dispose();
    capResCtrl.dispose();
    provinciaResCtrl.dispose();
    creditiCtrl.dispose();
    noteCtrl.dispose();
    super.onClose();
  }

  

  void toggleResidenza(bool? v){
    domDiversoRes = v ?? false;

    if(!domDiversoRes){
      viaDomCtrl.text = viaResCtrl.text;
      cittaDomCtrl.text = cittaResCtrl.text;
      capDomCtrl.text = capResCtrl.text;
      provinciaDomCtrl.text = provinciaResCtrl.text;
    }
    update();
  }

  void initUser() async {
    
    var user = AuthController.to.user;
    annoDiCorso = CareerController.to.currentCourseYear+1;
    annoDiTirocinio.value = CareerController.to.currentDirectInternshipYear+1;

    nomeCtrl.text = user?.registry?.firstName ?? '';
    cognomeCtrl.text = user?.registry?.lastName ?? '';
    matricolaCtrl.text = user?.university?.studentNumber ?? ''; 
    telefonoCtrl.text = user?.registry?.cellNumber ?? '';
    emailPersonaleCtrl.text = user?.registry?.personalEmail ?? '';
    emailIstituzionaleCtrl.text = user?.email ?? '';

    viaDomCtrl.text = user?.registry?.domicile?.street ?? '';
    cittaDomCtrl.text = user?.registry?.domicile?.city ?? '';
    capDomCtrl.text = user?.registry?.domicile?.cap ?? '';
    provinciaDomCtrl.text = user?.registry?.domicile?.province ?? ''; 

    viaResCtrl.text = user?.registry?.residence?.street ?? '';
    cittaResCtrl.text = user?.registry?.residence?.city ?? '';
    capResCtrl.text = user?.registry?.residence?.cap ?? '';
    provinciaResCtrl.text = user?.registry?.residence?.province ?? ''; 

    creditiCtrl.text = user?.university?.earnedCreditsNumber?.toString() ?? '';
    noteCtrl.text = user?.university?.earnedCreditsNotes ?? '';

    domDiversoRes = user?.registry?.domicile != user?.registry?.residence;

    update();
    
  }

  /// Fa un check sull'anno di corso e 
  /// mi ritorna quali anni di tirocinio sono effettivamente selezionabili.
  /// Ad esempio 3 anno di corso, potrà selezionare solo 1 e 2
  bool isAnnoTirocinioEnabled(int annoTirocinio) {
    return annoTirocinio<CareerController.to.currentCourseYear;
  }


  bool validateData(){
    int credits = int.tryParse(creditiCtrl.text) ?? 0;

    if(credits==0){
      Utils.showToast(isWarning: true, text: 'Inserire il numero di crediti maturati');
      return false;
    }

    int year = AuthController.to.user!.getStudentCourseYear();

    if(credits < StudentCreditsPerYear.limits[year]!.toInt() && noteCtrl.text.isEmpty){
      Utils.showToast(isWarning: true, text: 'Inserire le note sui crediti mancanti');
      return false;
    }

    return true;
  }

  void onSave() async {

    isSaving(true);
    int credits = int.tryParse(creditiCtrl.text) ?? 0;

    var user = UserModel(
      registry: Registry(
        firstName: nomeCtrl.text,
        lastName: cognomeCtrl.text,
        cellNumber: telefonoCtrl.text,
        personalEmail: emailPersonaleCtrl.text,
        domicile: House(
          cap: capDomCtrl.text,
          city: cittaDomCtrl.text,
          province: provinciaDomCtrl.text,
          street: viaDomCtrl.text,
        ),
        residence: House(
          cap: capResCtrl.text,
          city: cittaResCtrl.text,
          province: provinciaResCtrl.text,
          street: viaResCtrl.text,
        )
      ),
      university: University(
        earnedCreditsNumber: credits,
        earnedCreditsNotes: noteCtrl.text,
      ),
    );

    await AuthController.to.saveUser(user);
    isSaving(false);
  }
}