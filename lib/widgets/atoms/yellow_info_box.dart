import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';


class YellowInfoBox extends StatelessWidget {
  const YellowInfoBox({ required this.message, Key? key }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
        color: AppColors.yellow,
        boxShadow: [
          BoxShadow(
            color: Color(0x0036431A),
            offset: Offset(0.0, 4.0), 
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Center(
          child: Text(
            message, 
            textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Color(0xFF999999)
          ),
        ),
      ),
    ),);
  }
}