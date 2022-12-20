import 'package:flutter/material.dart';
import 'app_colors.dart';


abstract class AppStyles {

  static const TextStyle black14 = TextStyle(fontSize: 14, color: AppColors.black);
  static const TextStyle black16 = TextStyle(fontSize: 16, color: AppColors.black);
  static const TextStyle black17 = TextStyle(fontSize: 17, color: AppColors.black);

  static const TextStyle body14 = TextStyle(fontSize: 14, color: AppColors.subtitleText);
  static const TextStyle body16 = TextStyle(fontSize: 16, color: AppColors.subtitleText);
  

  static const TextStyle white14 = TextStyle(fontSize: 12, color: Colors.white);
  static const TextStyle white16 = TextStyle(fontSize: 16, color: Colors.white);

  static const TextStyle secondary16 = TextStyle(fontSize: 16, color: AppColors.secondary,);
  static const TextStyle secondary20 = TextStyle(fontSize: 20, color: AppColors.secondary);

  static const TextStyle primary16 = TextStyle(fontSize: 16, color: AppColors.primary);
  
  
  
  static const TextStyle primaryButton = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onPrimary);

  static const TextStyle textFieldLabel = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.black);
  static const TextStyle textFieldHint = TextStyle(fontSize: 14, color: AppColors.lightText);

  static const TextStyle titolo = TextStyle(fontSize: 20, fontFamily: 'Oswald', color: AppColors.secondary);

}

extension TextStyleX on TextStyle {

  TextStyle get lato => copyWith(fontFamily: 'Lato');
  TextStyle get oswald => copyWith(fontFamily: 'oswald');

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);



  // Colors
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get secondary => copyWith(color: AppColors.secondary);

}