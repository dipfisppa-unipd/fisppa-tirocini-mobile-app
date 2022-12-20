import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_colors.dart';
import 'package:unipd_mobile/widgets/alert_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Utils {

  static final DateFormat _fDate = DateFormat('dd/MM/yyyy');
  static final DateFormat _fDateTime = DateFormat('dd/MM/yyyy HH:mm');

  static String formatDate(DateTime d) => _fDate.format(d.toLocal());
  static String formatDateTime(DateTime d) => _fDateTime.format(d.toLocal());

  static showToast({String text='', bool isError=false, bool isWarning=false}){
    FToast fToast = FToast();
    fToast = fToast.init(Get.overlayContext!);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: isError ? AppColors.error : isWarning ? AppColors.warning : AppColors.success,
      ),
      child: Row(
      mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isError ? Icons.close : isWarning ? Icons.error : Icons.check, color: Colors.white,),
          const SizedBox(width: 12.0,),
          Flexible(child: Text(text, style: const TextStyle(color: Colors.white),)),
        ],
      ),
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
        fadeDuration: 260
    );
  }

  static openUrl(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication))
        showToast(isError: true, text: 'Impossibile aprire il collegamento');
    } on Exception catch (e) {
      print(e);
    }
  }

  static copy(String? term){
    if(term==null || term.isEmpty){
      showToast(isWarning: true, text: 'Nulla da copiare');
      return;
    }
    FlutterClipboard.copy(term).then(( value ) => showToast(
      text: 'Copiato: $term',
    ));
  }

  static void alertBox({String message='', String buttonText='CONFERMA', onTap}) {
    
    AlertBox alert = AlertBox(
      onTap: ()=>onTap(),
      button: buttonText,
      children: [
        Text(message, 
          style: TextStyle(fontSize: 22, fontFamily: 'Oswald', color: AppColors.secondary),
        ),
      ],
    );

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
    
  }

}