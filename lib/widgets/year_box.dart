import 'package:flutter/material.dart';


class YearBox extends StatelessWidget {
  
  const YearBox(this.year, {required this.onTap, Key? key, }) : super(key: key);

  final int year;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap!(),
      child: Container(
        alignment: Alignment.center,
        width: 90,
        height: 80,
        child: Text('$year', 
          style: TextStyle(fontSize: 32, fontFamily: 'Oswald', fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}