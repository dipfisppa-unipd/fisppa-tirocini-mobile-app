import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class CalendarController extends GetxController{

  static CalendarController get to => Get.find();

  final now = DateTime.now();

  bool isNextYearSubsClosed = true;

  int get currentYear => _isNewAcademicYear ? now.year+1 : now.year;
  int get nextYear => _isNewAcademicYear ? currentYear+2 : currentYear+1;
  
  String get currentAcademicYear => '${currentYear-1}/$currentYear';
  String get nextAcademicYear => '$currentYear/${currentYear+1}';

  bool _isNewAcademicYear = false;

  @override
  void onInit() {
    super.onInit();

    // L'anno accademico inizia a settembre
    if(now.month>=9){
      _isNewAcademicYear = true;
    }

    if(kDebugMode){
      print('----- ACADEMIC YEARS');
      print('Now: ${now.toLocal()}');
      print('Current Academic: $currentAcademicYear');
      print('Next Academic: $nextAcademicYear');
    }
  }

  bool get isNewAcademicYear => _isNewAcademicYear;


}