import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unipd_mobile/app/app_colors.dart';


class Loader extends StatelessWidget {
  final double size;
  final String? message;
  final Color color;

  const Loader({Key? key, this.size=30, this.message, this.color=AppColors.onPrimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: SpinKitThreeBounce(
        color: color,
        size: size-20,
      ),
    );
  }
}