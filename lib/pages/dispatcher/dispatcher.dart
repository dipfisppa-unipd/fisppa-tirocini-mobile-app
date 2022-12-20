import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/pages/dispatcher/dispatcher_controller.dart';
import 'package:unipd_mobile/utils/loader.dart';


class Dispatcher extends GetView<DispatcherController> {
  const Dispatcher({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onPrimary,
      body: Center(
        child: Loader(
          color: AppColors.background,
          size: 50,
        ),
      ),
    );
  }
}