import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';



class WebScreenOversize extends StatelessWidget {
  const WebScreenOversize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/logo-univers-padova.jpg', height: 260), 

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('L\'utilizzo della versione Web\nè ottimizzata per smartphones.',
                style: TextStyle(fontSize: 28, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}