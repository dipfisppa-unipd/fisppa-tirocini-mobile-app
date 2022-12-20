import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';

class MessageBox extends StatelessWidget {
  final Function onTap;
  final List<Widget> children;
  const MessageBox({ Key? key, required this.children, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: Get.height,
        width: Get.width,
        color: AppColors.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Container(
              height: Get.height/2,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000059),
                    offset: Offset(2.0, 1.0), 
                    blurRadius: 30.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          child: const SizedBox(height: 50, child: Center(child: Text('AVANTI', textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondary, fontSize: 18, fontWeight: FontWeight.bold),))),
          onTap: () => onTap(),
        ), 
      ),
    );
  }
}