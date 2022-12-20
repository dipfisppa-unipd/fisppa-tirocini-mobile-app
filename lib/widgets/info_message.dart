import 'package:flutter/material.dart';
import 'package:unipd_mobile/app/app_colors.dart';


class InfoMessage extends StatelessWidget {
  const InfoMessage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Text(_INFO_MESSAGE, style: TextStyle(color: AppColors.lightGrey),),
    );
  }
}


const String _INFO_MESSAGE = '''
Sono presenti gli istituti comprensivi e le scuole paritarie della regione Veneto e gli istituti comprensivi del Trentino. Se uno degli istituti di tuo interesse non è fra questi puoi indicarlo nelle note.
''';