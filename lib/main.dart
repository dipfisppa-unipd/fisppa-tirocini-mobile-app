import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:misslog/core/misslog.dart';
import 'package:unipd_mobile/bindings/initial_bindings.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:unipd_mobile/controllers/version_controller.dart';
import 'package:unipd_mobile/pages/dispatcher/dispatcher.dart';
import 'package:unipd_mobile/pages/web_screen_oversize.dart';
import 'package:unipd_mobile/repo/secure_repo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/app_pages.dart';
import 'app/app_routes.dart';
import 'app/app_theme.dart';
import 'pages/dispatcher/dispatcher_controller.dart';

void main() async {
  
  final repo = Get.put(SecureRepo(), permanent: true);
  await repo.readTokens();

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(VersionController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        title: 'UniPD Tirocini',
        initialRoute: AppRoutes.DISPATCHER,
        unknownRoute: GetPage(
          name: AppRoutes.DISPATCHER, 
          page: () => Dispatcher(),
          binding: BindingsBuilder.put(()=>DispatcherController()),
        ),
        builder: (_, child){
          return LayoutBuilder(
            builder: (__, constraints){
              
              if(!kIsWeb) return child!;
              
              if(constraints.maxWidth>600){
                return WebScreenOversize();
              }

              return child!;
            },
          );
        },
        getPages: AppPages.list,
        defaultTransition: Transition.cupertino,
        theme: themeData(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('it', 'IT'),
        ],
        routingCallback: (routing) {
          
          if(kIsWeb)
          MissLog.i('---> ${routing?.current}');
    
          if(kIsWeb 
            && routing?.current != AppRoutes.DISPATCHER 
            && routing?.current != AppRoutes.LOGIN) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              AuthController.to.guard();
            });
          }
        }
      ),
    );
  }
}