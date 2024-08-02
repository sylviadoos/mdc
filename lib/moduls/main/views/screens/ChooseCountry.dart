import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/main/views/screens/Countries.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'dart:io';
import 'dart:ui';
class ChooseCountry extends StatelessWidget {
  ChooseCountry({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MainController>(builder: (logic) {
          return
            Column(children: [
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/locimg.png"),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [


                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    )),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Text(
                                        'Choose your country'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),SizedBox(height: 10,),
                                      Text(
                                        'to find all services near by you'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                                          child: Container(
                                              width: 500,
                                              child: TextButton(
                                                  onPressed: () async {
                                                    Get.offAll(CountriesScreen());
                                                  },
                                                  style: ButtonStyle(
                                                      minimumSize: MaterialStateProperty
                                                          .all(Size(
                                                          double.infinity, 43)),
                                                      maximumSize: MaterialStateProperty
                                                          .all(Size(
                                                          double.infinity, 53)),
                                                      backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Theme.of(context).primaryColor),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20.0),
                                                              side: BorderSide(
                                                                  color: Color(
                                                                      0xFF88E4FC))))),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      'Select country'.tr,
                                                      textAlign: TextAlign
                                                          .right,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontFamily: 'Cairo',
                                                        fontWeight: FontWeight
                                                            .w600,
                                                      ),
                                                    ),
                                                  ))
                                          )
                                      )

                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )
                    // Foreground widget here
                  )),
            ]);
        }),
      ),
    );
  }

}
