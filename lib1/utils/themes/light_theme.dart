import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
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
            statusBarColor: Color(0xffffffff))),
    primaryColor: const Color(0xff00416B),
    secondaryHeaderColor: HexaColor.fromHexa('#00A19B'),
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white,),
        bodySmall:
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
            fontWeight: FontWeight.w600)),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            textStyle: TextStyle(
              fontFamily: Get.locale.toString() == "en"
                  ? "Klavika"
                  : GoogleFonts.tajawal().fontFamily,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
            backgroundColor: const Color(0xff00416B),
            fixedSize: Size(double.infinity, 44.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      // alignment: Alignment.center,
      // textStyle: TextStyle(
      //   fontFamily: Get.locale.toString() == "en"
      //       ? "Klavika"
      //       : GoogleFonts.tajawal().fontFamily,
      //   fontSize: 18.sp,
      //   fontWeight: FontWeight.bold,
      //   color: const Color(0xffffffff),
      // ),
      backgroundColor: const Color(0xff00416B),
      // sizeConstraints: Size(double.infinity, 44.h),
    ),
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
