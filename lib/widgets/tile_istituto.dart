import 'package:flutter/material.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/pages/tirocinio_diretto/direct_internship_controller.dart';
import 'package:unipd_mobile/models/direct/istituti_tirocinio_diretto.dart';
import 'package:unipd_mobile/utils/utils.dart';

/// [withFakeInfanzia] is used to fake the data in the final choice screen
/// about "Istituti comprensivi"
/// that are the only choice, therefore they must 
/// have school od type "Infanzia"
/// 
class TileIstituto extends StatelessWidget {
  final InstituteModel? istituto;
  final bool withTrailing;
  final bool withFakeInfanzia, checked;
  final Function? onTap;
  
  const TileIstituto({
    Key? key, 
    required this.istituto, 
    this.withTrailing = true, 
    this.onTap,
    this.withFakeInfanzia=false,
    this.checked=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return InkWell(
          onTap: onTap==null ? null : ()=>onTap!(),
          onLongPress: (){
            Utils.copy(istituto?.referenceInstituteCode);
            print('Num of institutes: ${istituto?.schools.length}');
          },
          child: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      child: withTrailing ? DirectInternshipController.to.generateTrailing(istituto!) ?? const SizedBox() : SizedBox(),
                    ),

                    if(checked)
                    ClipOval(
                      child: Container(
                        height: 40,
                        width: 40,
                        color: AppColors.secondary,
                        child: Center(child: Icon(Icons.check, color: Colors.white,)),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(istituto!.schoolType == "NORMALE" ? "STATALE" : "PARITARIA"),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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


                    if(istituto!.isInfanzia || istituto!.isInfanziaParitaria || withFakeInfanzia) 
                      const Text("INFANZIA", style: TextStyle(color: AppColors.lightBlue, fontSize: 12),),
                    
                    const SizedBox(width: 10,),
                    
                    if(istituto!.isPrimaria || istituto!.isPrimariaParitaria) 
                      const Text("PRIMARIA", style: TextStyle(fontSize: 12, color: AppColors.green),),

                  ],
                ),

              ],
            ),
          ),
        );

  }
}