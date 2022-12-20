import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const HomeButton({ Key? key, required this.text, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        height: 100,
        color: AppColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: const TextStyle(fontSize: 22, fontFamily: 'Oswald', color: Colors.black), textAlign: TextAlign.center,),
        ),
      ),
      onTap: onTap,
    );
  }
}