import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_routes.dart';
import 'package:unipd_mobile/pages/dispatcher/dispatcher.dart';
import 'package:unipd_mobile/pages/dispatcher/dispatcher_controller.dart';
import 'package:unipd_mobile/pages/home/career_controller.dart';
import 'package:unipd_mobile/pages/home/home_page.dart';
import 'package:unipd_mobile/pages/iscrizione/iscrizione_tirocinio.dart';
import 'package:unipd_mobile/pages/iscrizione/iscrizione_tirocinio_controller.dart';
import 'package:unipd_mobile/pages/login.dart';

abstract class AppPages{
  static List<GetPage<dynamic>> list =  [

    GetPage(
      name: AppRoutes.DISPATCHER, 
      page: () => Dispatcher(),
      binding: BindingsBuilder.put(()=>DispatcherController()),
    ),

    GetPage(
      name: AppRoutes.LOGIN, 
      page: () => Login()
    ),

    GetPage(
      name: AppRoutes.HOME, 
      page: () => const HomePage(),
      binding: BindingsBuilder.put(() => CareerController(), permanent: true)
    ),

    GetPage(
      name: AppRoutes.ISCRIZIONE, 
      page: () => IscrizioneTirocinio(),
      binding: BindingsBuilder.put(() => IscrizioneTirocinioController())
    ),
    
  ];
}