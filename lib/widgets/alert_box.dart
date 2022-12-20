import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';

class AlertBox extends StatelessWidget {
  final Function onTap;
  final List<Widget> children;
  const AlertBox({ Key? key, required this.children, required this.onTap, this.showIcon = true, this.button = "CONFERMA" }) : super(key: key);

  final bool showIcon;
  final String button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 350,
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  showIcon ? Row(
                    children: [
                      const Spacer(),
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)) 
                    ],
                  ) : const SizedBox(height: 25,),
                  ...children
                ],
              ),
            ),
  
            InkWell(
              child: Container(
                width: 350,
                height: 60,
                color: AppColors.secondary,
                child: Center(child: Text(button, style: const TextStyle(color: AppColors.onSecondary, fontSize: 18, fontWeight: FontWeight.bold),)),
              ),
  
              onTap: () => onTap(),
            )
          ],
        ),
      )
    );
  }
}