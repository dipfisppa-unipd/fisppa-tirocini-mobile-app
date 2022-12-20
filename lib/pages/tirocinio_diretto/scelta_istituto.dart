import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/search/search_bar_institutes.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/info_message.dart';
import 'package:unipd_mobile/widgets/tile_istituto.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class SceltaIstituto extends GetView<DirectInternshipController> {

  const SceltaIstituto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Tirocinio diretto", style: TextStyle(color: Colors.white),),
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TODO: vuoi confermare l'istituto precedente?
                // TODO: bisogna mettere uno skip nel caso non serva infanzia

                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                  child: Text("Scelta Istituti di riferimento per Tirocinio Diretto", style: AppStyles.titolo,),
                ),

                const YellowInfoBox(
                  message: 'Effettua la tua scelta, tap di nuovo per annullarla. Inserisci il CAP, la città oppure il nome dell\'istituto desiderato.\nTieni premuto per copiare il codice di riferimento.',
                ),
                
                const SizedBox(height:  6,),

                const InfoMessage(),
          
                SearchBarInstitutes(),

                if(!CareerController.to.isPrimaryInfancyRequired)
                GetBuilder<DirectInternshipController>(
                  builder: (ctrl) {
                    return SwitchListTile(
                      contentPadding: const EdgeInsets.only(left: 20, right: 20),
                      onChanged: (b){
                        ctrl.setOnlyInfancy(b);
                      },
                      value: ctrl.showInfanziaOnly,
                      activeColor: AppColors.onPrimary,
                      title: Text('Mostra solo scuole dell\'infanzia'),
                    );
                  }
                ),

          
                const SizedBox(height: 20,),
          
                GetBuilder<DirectInternshipController>(
                  builder: (ctrl) {

                    if(ctrl.isLoading)
                    return Center(
                      child: Loader(size: 60,),
                    );

                    if(ctrl.paramRicerca.text.isNotEmpty && ctrl.foundInstitutes.isEmpty)
                    return Center(
                      child: Text('Nessun risultato'),
                    );

                    return WhiteBox(
                      children: [
                        
                        if(!ctrl.showInfanziaOnly)
                        for(InstituteModel i in ctrl.foundInstitutes)
                          if(i.isComprensivo) 
                            TileIstituto(istituto: i, onTap: ()=>ctrl.tapToggle(i),),

                        if(!ctrl.showInfanziaOnly)
                        for(InstituteModel i in ctrl.foundInstitutes)
                          if(i.isPrimariaParitaria) 
                            TileIstituto(istituto: i, onTap: ()=>ctrl.tapToggle(i),),

                        if(!CareerController.to.isPrimaryInfancyRequired)
                        for(InstituteModel i in ctrl.foundInstitutes)
                          if(i.isInfanziaParitaria) 
                            TileIstituto(istituto: i, onTap: ()=>ctrl.tapToggle(i),),
                            

                      ], 
                      withPadding: true,
                    );
                  }
                ),
          
              ],
            ),
          ),

          bottomNavigationBar: BottomAppBar(
            color: AppColors.secondary, 
            child: TextButton(
              onPressed: () {
                controller.checkPrimaryOnly();
              },
              child: const Text(
                "AVANTI", 
                style: TextStyle(
                  color: AppColors.onSecondary, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              )
            )
          ),
        );
  }
}

