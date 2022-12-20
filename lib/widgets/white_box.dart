import 'package:flutter/material.dart';

class WhiteBox extends StatelessWidget {
  final List<Widget> children;
  final bool withPadding;
  final ScrollController? controller;
  const WhiteBox({ Key? key, required this.children, required this.withPadding, this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: withPadding ? 20 : 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}