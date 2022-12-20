import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/app/app_styles.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/utils/loader.dart';
import 'package:unipd_mobile/widgets/atoms/yellow_info_box.dart';
import 'package:unipd_mobile/widgets/white_box.dart';

class SceltaIstitutiStep2 extends GetView<DirectInternshipController> {
  
  final List<DirectInternshipChoice> scelta;
  final int index;

  const SceltaIstitutiStep2({ 
    Key? key, 
    required this.scelta, 
    required this.index 
  }) : super(key: key);

  String valueTextChoice(){
    switch(index){
      case 0: return 'PRIMA';
      case 1: return 'SECONDA';
      case 2: return 'TERZA';
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
          appBar: AppBar(
            title: const Text("Tirocinio diretto"),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 8, 18, 35),
                  child: Text("Scelta Istituti di riferimento per Tirocinio Diretto", 
                    style: AppStyles.titolo,
                  ),
                ),

                YellowInfoBox(
                  message: 'La tua ${valueTextChoice()} scelta ha solo la scuola primaria, procedere anche nella scelta della scuola dell\'infanzia proposte in elenco.',
                ),
                
          
                const SizedBox(height:  20,),
          
                Container(
                  color: AppColors.lightText,
                  height: 50,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox( width: 15),
                      Flexible(
                        child: TextField(
                          controller: controller.paramRicerca,
                          onSubmitted: (s){
                            controller.searchIstituti(onlyInfancy: true);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Cerca per istituto, città o CAP',
                          ),
                        ),
                      ),
                      /* Text("Cerca per Istituto o CAP"),
                      Text("35100"), */
                      IconButton(icon: Icon(Icons.search), onPressed: () => controller.searchIstituti(onlyInfancy: true),),
                      const SizedBox( width: 15),
                    ],
                  ),
                ),
          
                const SizedBox(height: 40,),

                GetBuilder<DirectInternshipController>(
                  builder: (ctrl) {

                    if(ctrl.isLoading)
                    return Center(
                      child: Loader(size: 60,),
                    );

                    return WhiteBox(
                      children: [
                        for(InstituteModel i in ctrl.foundInstitutes)
                          if(i.isInfanziaParitaria)
                            TileIstitutoStep2(istituto: i, scelte: scelta, index: index,)
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
              onPressed: controller.checkPrimaryOnly, 
              child: const Text("AVANTI", 
                style: TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),
              )
            )
          ),
        );
      
  }
}


class TileIstitutoStep2 extends StatelessWidget {
  final InstituteModel? istituto;
  final bool withTrailing;
  final bool toggable;

  final List<DirectInternshipChoice> scelte;
  final int index;
  
  const TileIstitutoStep2({
    Key? key, required this.istituto, this.withTrailing = true, this.toggable = true, required this.scelte, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DirectInternshipController>(
      builder: (ctrl) {
        return InkWell(
          onTap: toggable ? () => ctrl.tapToggleStep2(istituto!, index) : null,
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(istituto!.name ?? "", style: const TextStyle(fontSize: 16, color: Colors.black),),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: withTrailing ? ctrl.generateTrailingStep2(istituto!) ?? const SizedBox() : SizedBox(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(istituto!.schoolType == "NORMALE" ? "STATALE" : "PARITARIA")
                  ],
                ),
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${istituto!.city}', style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),),
                          Text('${istituto!.address} - ${istituto!.cap}', 
                            maxLines: 2,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
                            overflow: TextOverflow.ellipsis,
                          ),
                    
                        ],
                      ),
                    ),
                    
                    istituto!.isInfanzia  || istituto!.isInfanziaParitaria ?  const Text("INFANZIA", style: TextStyle(color: AppColors.lightBlue, fontSize: 13),) : const SizedBox(),
                    const SizedBox(width: 10,),
                    istituto!.isPrimaria  || istituto!.isPrimariaParitaria ?  const Text("PRIMARIA", style: TextStyle(fontSize: 13, color: AppColors.green),) : const SizedBox()
                  ],
                ),
                const Divider()
              ],
            ),
          ),
        );
      }
    );
  }
}

