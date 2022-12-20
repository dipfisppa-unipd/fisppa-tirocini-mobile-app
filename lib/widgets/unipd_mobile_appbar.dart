import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';

class UnipdMobileHeader extends StatelessWidget{

  const UnipdMobileHeader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 130,
      color: AppColors.onPrimary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          
          Text("GESTIONE TIROCINI", style: TextStyle(fontSize: 22, fontFamily: 'Oswald', color: Colors.white),),
          
          SizedBox(height: 8,),
          
          Flexible(
            child: Text("Corso di Laurea in Scienze della Formazione Primaria", 
              style: TextStyle(color: AppColors.lightRed, fontSize: 18, fontFamily: 'Oswald'),
              textAlign: TextAlign.center,
            ),  
          ),

        ],
      ),
    );
  }
  
}