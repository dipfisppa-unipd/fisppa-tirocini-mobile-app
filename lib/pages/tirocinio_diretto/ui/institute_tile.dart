import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_colors.dart';
import '../../../models/direct/istituti_tirocinio_diretto.dart';
import '../../../widgets/tile_istituto.dart';
import '../direct_internship_controller.dart';

class InstituteTile extends GetView<DirectInternshipController> {

  final String? numeroScelta;
  final InstituteModel? scelta1;
  final InstituteModel? scelta2;

  const InstituteTile({
    Key? key, this.numeroScelta, required this.scelta1, this.scelta2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          if(numeroScelta!=null)
          Text(numeroScelta!, style: const TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary),),
          const SizedBox(height: 2,),
          
          TileIstituto(
            istituto: scelta1, 
            withTrailing: false, 
            withFakeInfanzia: controller.isDone && scelta2==null,
          ),
          
          if(scelta2 != null) 
          TileIstituto(
            istituto: scelta2, 
            withTrailing: false, 
          ),
          
        ],
      ),
    );
  }
}