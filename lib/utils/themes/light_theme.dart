import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    useMaterial3: false, // Optional: disable Material 3

    iconTheme: const IconThemeData(color: Color(0xff000000), size: 12),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xffFFFFFF),
        selectedItemColor: const Color(0xff00416B),
        selectedLabelStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xff00416B)),
        unselectedLabelStyle:
            TextStyle(fontSize: 13.sp, color: const Color(0xff999999)),
        unselectedItemColor: const Color(0xffBDBDBD)),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 21),
        backgroundColor: HexaColor.fromHexa('#174151'),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            statusBarColor: Color(0xff00416B)
        )),
    primaryColor: const Color(0xff00416B),
    secondaryHeaderColor: HexaColor.fromHexa('#00A19B'),
    textTheme: TextTheme(
        titleSmall:
            TextStyle(fontSize: 14.sp, color: HexaColor.fromHexa('#4F4F4F')),
        titleMedium: TextStyle(
            fontSize: 15.sp,
            color: const Color(0xff4F4F4F),
            fontWeight: FontWeight.w400),
        displayMedium: TextStyle(
            fontSize: 22.sp,
            color: const Color(0xff000000),
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
            fontSize: 16.sp,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w600),

      // Add the rest to override purple defaults:
      bodySmall: TextStyle(color:  Colors.white),
      bodyLarge: TextStyle(color:  Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color:  Colors.white),
      titleLarge: TextStyle(color:  Colors.white),
      headlineSmall: TextStyle(color:  Colors.white),
      headlineMedium: TextStyle(color:  Colors.white),
      headlineLarge: TextStyle(color:  Colors.white),
      displaySmall: TextStyle(color:  Colors.white),
      displayLarge: TextStyle(color:  Colors.white),),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center, backgroundColor: const Color(0xff00416B),
            textStyle: TextStyle(
              fontFamily: Get.locale.toString() == "en"
                  ? "Klavika"
                  : GoogleFonts.tajawal().fontFamily,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            fixedSize: Size(double.infinity, 44.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: TextStyle(
        fontFamily: Get.locale.toString() == "en"
            ? "Klavika"
            : GoogleFonts.tajawal().fontFamily,
        fontSize: 16.sp,
        color: const Color(0xff174151),
      ),
      fixedSize: Size(double.infinity, 30.h),
    )));

extension HexaColor on Color {
  static Color fromHexa(String hexa) {
    hexa = hexa.replaceAll('#', '');
    if (hexa.length == 6) {
      hexa = "FF" + hexa;
    }
    return Color(int.parse(hexa, radix: 16));
  }
}
