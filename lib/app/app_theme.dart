import 'package:flutter/material.dart';
import 'app_colors.dart';


ThemeData themeData(){

  return ThemeData(
    fontFamily: 'OpenSans',
    indicatorColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Lato'),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Oswald'),
      color: AppColors.onPrimary,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: Colors.white, size: 24,
      ),
      shadowColor: Color(0xFF000033),
    ),
    // primarySwatch: MaterialColor(0xFF36BFD8, {
    // 50:Color.fromRGBO(54,191,216, .1),
    // 100:Color.fromRGBO(54,191,216, .2),
    // 200:Color.fromRGBO(54,191,216, .3),
    // 300:Color.fromRGBO(54,191,216, .4),
    // 400:Color.fromRGBO(54,191,216, .5),
    // 500:Color.fromRGBO(54,191,216, .6),
    // 600:Color.fromRGBO(54,191,216, .7),
    // 700:Color.fromRGBO(54,191,216, .8),
    // 800:Color.fromRGBO(54,191,216, .9),
    // 900:Color.fromRGBO(54,191,216, 1),
    // }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary, 
      primaryContainer: AppColors.secondary,
      onPrimary: AppColors.onPrimary, 
      secondary: AppColors.secondary, 
      onSecondary: AppColors.secondary,
      secondaryContainer: AppColors.secondary,
      background: AppColors.secondary,
      onBackground: AppColors.secondary,
      surface: AppColors.secondary,
      onSurface: AppColors.secondary,
      error: AppColors.secondary,
      onError: AppColors.secondary,
    ),    
    // buttonColor: AppColors.action,
    // accentTextTheme: TextTheme(
    //   headline1: TextStyle(fontSize: 28, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline2: TextStyle(fontSize: 24, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline3: TextStyle(fontSize: 20, color: AppColors.accent, fontWeight: FontWeight.w500),
    //   headline4: TextStyle(fontSize: 18, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline5: TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   headline6: TextStyle(fontSize: 14, color: AppColors.accent,),
    //   subtitle1: TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   subtitle2: TextStyle(fontSize: 14, color: AppColors.accent, fontWeight: FontWeight.w700),
    //   bodyText1: TextStyle(fontSize: 16, color: AppColors.accent,),
    //   bodyText2: TextStyle(fontSize: 14, color: AppColors.accent,),
    //   button: TextStyle(fontSize: 20, color: AppColors.accent,),
    // ),
    // primaryTextTheme: TextTheme( 
    //   headline1: TextStyle(fontSize: 28, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline2: TextStyle(fontSize: 24, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline3: TextStyle(fontSize: 20, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline4: TextStyle(fontSize: 18, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline5: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    //   headline6: TextStyle(fontSize: 14, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   subtitle1: TextStyle(fontSize: 18, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   subtitle2: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   bodyText1: TextStyle(fontSize: 16, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   bodyText2: TextStyle(fontSize: 14, color: AppColors.primaryTextColor, fontFamily: 'Lato'),
    //   button: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
    // ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      bodyText2: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      caption: TextStyle(color: AppColors.text, fontFamily: 'Lato'),
      subtitle1: TextStyle(color: AppColors.onSurface, fontFamily: 'Lato'),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.onPrimary,
      selectionColor: AppColors.onPrimary,
      selectionHandleColor: AppColors.onPrimary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.secondary,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.only(right: 10, left: 14),
      horizontalTitleGap: 0,
      selectedTileColor: AppColors.secondary,
      minVerticalPadding: 0,
      selectedColor: AppColors.secondary
    ),
    inputDecorationTheme: const InputDecorationTheme(
      // focusColor: AppColors.accent,
      labelStyle: TextStyle(color: Color(0xFFA7A7A7), fontSize: 15),
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightText, width: 0.8)
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary, width: 0.8)
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary, width: 0.8)
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightText, width: 0.8)
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary, width: 0.8)
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary, width: 0.8)
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    //     side: BorderSide(color: AppColors.borderDisabledColor),
    //   )
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: OutlinedButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
    //     side: BorderSide(color: AppColors.borderDisabledColor),
    //   )
    // ),
    // timePickerTheme: TimePickerThemeData(
    //   backgroundColor: AppColors.accentBlue,
    // ),
    
  );
}