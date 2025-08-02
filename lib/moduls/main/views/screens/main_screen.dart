import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (logic) {
      return Scaffold(
        body: logic.screen[logic.selectedIndex],
        backgroundColor: HexaColor.fromHexa('#F6F6F6'),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: logic.onItemTapped,
          currentIndex: logic.selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/Path 10.svg',
                  width: 22.w,
                  height: 20.h,
                  color: logic.selectedIndex == 0
                      ? Theme.of(context).primaryColor
                      : HexaColor.fromHexa('#C6C6C6'),
                ),
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/cartcolord.svg',
                  width: 22.w,
                  height: 20.h,
                  color: logic.selectedIndex == 1
                      ? Theme.of(context).primaryColor
                      : HexaColor.fromHexa('#C6C6C6'),
                ),
              ),
              label: 'RequestCard'.tr,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/evidence.svg',
                  width: 22.w,
                  height: 20.h,
                  color: logic.selectedIndex == 2
                      ? Theme.of(context).primaryColor
                      : HexaColor.fromHexa('#C6C6C6'),
                ),
              ),
              label: 'guide'.tr,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/personcolord.svg',
                  width: 22.w,
                  height: 20.h,
                  color: logic.selectedIndex == 3
                      ? Theme.of(context).primaryColor
                      : HexaColor.fromHexa('#C6C6C6'),
                ),
              ),
              label: 'profile'.tr,
            ),
          ],
        ),
      );
    });
  }
}
