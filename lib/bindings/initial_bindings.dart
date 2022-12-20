import 'package:get/instance_manager.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/services/api_service.dart';

import '../controllers/calendar_controller.dart';


class InitialBindings implements Bindings {
  @override
  void dependencies() {
    
    Get.put(ApiService());
    Get.put(AuthController());
    Get.put(CalendarController());

  }
  
}