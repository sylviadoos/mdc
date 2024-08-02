import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'dart:io';
import 'dart:ui';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<MainController>(builder: (logic) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        exit(0);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 22.w,
                        ),
                      ),
                    ),
                    Text(
                      'Select country'.tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .030,
                ),
                Flexible(
                  child: ListView.separated(
                      itemBuilder: (c, i) {
                        return ListTile(
                          leading: Image.asset(
                            logic.countryModel[i].imgPath!,
                            width: 40,
                            height: 40,
                          ),
                          onTap: () {
                            logic.changeSelectCountry(
                                logic.countryModel[i].name!,
                                logic.countryModel[i].id!);
                            Get.back();
                          },
                          // padding: EdgeInsets.zero,
                          title: Text(logic.countryModel[i].name!),
                        );
                      },
                      separatorBuilder: (c, i) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            DottedBorder(
                              color: HexaColor.fromHexa('#E8E8E8'),
                              dashPattern: const [8, 4],
                              strokeWidth: .5,
                              customPath: (size) {
                                return Path()
                                  ..moveTo(0, 0)
                                  ..lineTo(size.width, 0);
                              },
                              child: Container(),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        );
                      },
                      itemCount: logic.countryModel.length),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
