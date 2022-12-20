import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_config.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/controllers/calendar_controller.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/iscrizione/iscrizione_tirocinio_controller.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/utils/utils.dart';
import 'package:unipd_mobile/widgets/alert_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class IscrizioneTirocinio extends GetView<IscrizioneTirocinioController> {
  
  IscrizioneTirocinio({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrazione tirocinante", 
          style: TextStyle(color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: WhiteBox(
          controller: controller.scrollController,
          withPadding: true,
            children: [
      
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                child: const Text("Informazioni anagrafiche", style: AppStyles.titolo,),
              ), 
      
              Form(
                key: controller.anagraficaFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    SizedBox(
                      width: Get.width - 36,
                      child: TextFormField(
                        controller: controller.nomeCtrl, 
                        validator: (s){
                          if(s==null || s.isEmpty) return 'Nome obbligatorio';
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        )
                      ),
                    ),
                    const SizedBox(height: 10,),
      
                    SizedBox(
                      width: Get.width - 36,
                      child: TextFormField(
                        controller: controller.cognomeCtrl, 
                        validator: (s){
                          if(s==null || s.isEmpty) return 'Cognome obbligatorio';
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Cognome'),
                        )
                      ),
                    ),
      
                    const SizedBox(height: 10,),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller.matricolaCtrl, 
                            readOnly: true,
                            enabled: false,
                            keyboardType: TextInputType.number,
                            validator: (s){
                              if(s==null || s.isEmpty) return 'Matricola obbligatoria';
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text('Matricola'),
                            )
                          ),
                        ),
                          
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller.telefonoCtrl, 
                            validator: (s){
                              if(s==null || s.isEmpty) return 'Telefono obbligatorio';
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Telefono'),
                              
                            )
                          ),
                        ),
                      ],
                    ),
      
                    const SizedBox(height: 10,),
      
                    TextFormField(
                      initialValue: AuthController.to.user?.email ?? '',
                      readOnly: true,
                      enabled: false,
                      decoration: const InputDecoration(
                        label: Text('Indirizzo email istituzionale'),
                      )
                    ),
      
                    const SizedBox(height: 10,),
      
                    TextFormField(
                      controller: controller.emailPersonaleCtrl, 
                      keyboardType: TextInputType.emailAddress,
                      validator: (s){
                        if(s!=null && !EmailValidator.validate(s)) 
                          return 'Email non valida';
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Indirizzo email personale'),
                      )
                    ),
                  
      
                    const SizedBox(height: 35,),
      
                    const Text("Informazioni di residenza", style: AppStyles.titolo,), 
      
                    const SizedBox(height: 15,),
      
                    SizedBox(
                      width: Get.width - 36,
                      child: TextFormField(
                        controller: controller.viaResCtrl, 
                        validator: (s){
                          if(s==null || s.isEmpty) return 'Via obbligatoria';
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Via'),
                        )
                      ),
                    ),
      
                    const SizedBox(height: 10,),
      
                    SizedBox(
                      width: Get.width - 36,
                      child: TextFormField(
                        controller: controller.cittaResCtrl, 
                        validator: (s){
                          if(s==null || s.isEmpty) return 'Città obbligatoria';
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Città'),
                        )
                      ),
                    ),
      
                    const SizedBox(height: 10,),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller.capResCtrl, 
                            keyboardType: TextInputType.number,
                            validator: (s){
                              if(s==null || s.isEmpty) return 'CAP obbligatorio';
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text('CAP'),
                            )
                          ),
                        ),
                          
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: controller.provinciaResCtrl, 
                            validator: (s){
                              if(s==null || s.isEmpty) return 'Provincia obbligatoria';
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text('Provincia'),
                            )
                          ),
                        ),
                      ],
                    ), 
                  ],
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
      
                    GetBuilder<IscrizioneTirocinioController>(
                      builder: (ctrl) { 
                        return Checkbox(
                          activeColor: AppColors.secondary,
                          value: controller.domDiversoRes, 
                          onChanged: controller.readOnly.value 
                            ? null 
                            : (value) {
                              controller.toggleResidenza(value);
                            },     
                          
                        );
                      }
                    ),
                    
                    const Text("Domicilio diverso dalla residenza"),
                    
                  ],
                ),
              ),
      
              GetBuilder<IscrizioneTirocinioController>(
                builder: (ctrl) {
      
                  if(!ctrl.domDiversoRes) return SizedBox();
      
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25,),
      
                      const Text("Informazioni di domicilio", style: AppStyles.titolo,), 
      
                      const SizedBox(height: 15,),
      
                      Form(
                        key: controller.domicilioFormKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width - 36,
                              child: TextFormField(
                                controller: controller.viaDomCtrl, 
                                validator: (s){
                                  if(s==null || s.isEmpty) return 'Via obbligatoria';
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text('Via'),
                                )
                              ),
                            ),
      
                            const SizedBox(height: 10,),
      
                            SizedBox(
                              width: Get.width - 36,
                              child: TextFormField(
                                controller: controller.cittaDomCtrl, 
                                validator: (s){
                                  if(s==null || s.isEmpty) return 'Città obbligatoria';
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  label: Text('Città'),
                                )
                              ),
                            ),
      
                            const SizedBox(height: 10,),
      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    controller: controller.capDomCtrl, 
                                    keyboardType: TextInputType.number,
                                    validator: (s){
                                      if(s==null || s.isEmpty) return 'CAP obbligatorio';
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('CAP'),
                                    )
                                  ),
                                ),
                                  
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    controller: controller.provinciaDomCtrl, 
                                    validator: (s){
                                      if(s==null || s.isEmpty) return 'Provincia obbligatoria';
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Provincia'),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
      
              const SizedBox(height: 25,),

              if(!CalendarController.to.isNextYearSubsClosed)...[

                Text("Richiesta di tirocino ${CalendarController.to.nextAcademicYear}", style: AppStyles.titolo,), 
      
                const SizedBox(height: 15,),
                
                const Text("Anno di corso", style: TextStyle(color: AppColors.lightGrey, fontSize: 15),),
                Row(
                  children: [
                    Radio(value: controller.annoDiCorso, groupValue: controller.annoDiCorso, onChanged: null, activeColor: AppColors.secondary),
                    Text('${controller.annoDiCorso}'),
                    const Spacer()
                  ],
                ), 
        
                const SizedBox(height: 15),
        
                const Text("Anno di tirocinio", style: TextStyle(color: AppColors.lightGrey, fontSize: 15),),
                  
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text("1"),
                          leading: Radio(
                            value: 1,
                            groupValue: controller.annoDiTirocinio.value,
                            onChanged: null,
                            activeColor: AppColors.secondary,
                            
                          ),
                        )
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("2"),
                          leading: Radio(
                            value: 2,
                            groupValue: controller.annoDiTirocinio.value,
                            onChanged: null,
                            activeColor: AppColors.secondary,
                            
                          ),
                        )
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("3"),
                          leading: Radio(
                            value: 3,
                            groupValue: controller.annoDiTirocinio.value,
                            onChanged: null,
                            activeColor: AppColors.secondary,
                            
                          ),
                        )
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text("4"),
                          leading: Radio(
                            value: 4,
                            groupValue: controller.annoDiTirocinio.value,
                            onChanged: null,
                            activeColor: AppColors.secondary,
                            
                          ),
                        )
                      ),
                      const Spacer()
                    ],
                  ),
                ),

              ],
      
              const SizedBox(height: 15),
      
              const Text("Inserire il numero di crediti maturati.", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              if(!CalendarController.to.isNextYearSubsClosed)
              Text('Per accedere al ${CareerController.to.currentDirectInternshipYear+1} anno di tirocinio è richiesto un minimo di ${StudentCreditsPerYear.limits[CareerController.to.currentDirectInternshipYear+1]} crediti. Indicare nelle note eventuali crediti non ancora registrati.', 
                style: TextStyle(color: AppColors.lightGrey, fontSize: 15),
              ),
      
              SizedBox(
                width: 66,
                child: TextFormField(
                  controller: controller.creditiCtrl, 
                  keyboardType: TextInputType.number,
                  validator: (s){
                    if(s==null || s.isEmpty) return 'Campo obbligatorio';
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('Crediti'),
                    suffix: CalendarController.to.isNextYearSubsClosed 
                      ? Text('',)
                      : Text('/${StudentCreditsPerYear.limits[CareerController.to.currentDirectInternshipYear+1]}',),
                  )
                ),
              ),
      
              const SizedBox(height: 15),
      
              const Text("Inserire eventuali note relative ai crediti maturati", 
                style: TextStyle(color:AppColors.lightGrey, fontSize: 15),
              ),
      
              TextFormField(
                controller: controller.noteCtrl, 
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text('Note'),
                ),
              ),
      
              const SizedBox(height: 100,)
      
            ],
        ),
      ),
      
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: GetPlatform.isIOS ? 70 : 50,
          child: BottomAppBar(
            color: AppColors.secondary,
            child: controller.isSaving() ? Loader(color: Colors.white,) : InkWell(
              child: const SizedBox(
                height: 50, 
                child: Center(child: Text('AVANTI', textAlign: TextAlign.center, style: TextStyle(color: AppColors.onSecondary, fontSize: 18,),))),
              onTap: () {

                if(!controller.anagraficaFormKey.currentState!.validate()){
                  Utils.showToast(isWarning: true, text: 'Compilare tutti i campi');
                  return;
                }

                if(controller.domDiversoRes && !controller.domicilioFormKey.currentState!.validate()){
                  Utils.showToast(isWarning: true, text: 'Mancano alcuni campi del domicilio');
                  return;
                }

                if(!controller.validateData()) return;

                showAlertDialog(context);
                
                controller.scrollController.jumpTo(0);
              },
            ), 
          ),
        ),
      ),
      
    );
  }

  showAlertDialog(BuildContext context) {
    AlertBox alert = AlertBox(
      onTap: (){
        controller.onSave();
        Get.back();
        FocusScope.of(context).requestFocus(FocusNode());
      
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

// end
}