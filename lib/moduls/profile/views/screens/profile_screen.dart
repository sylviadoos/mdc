import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/profile/controller/profile_controller.dart';
import 'package:mdc_card/moduls/profile/views/screens/contact_us.dart';
import 'package:mdc_card/moduls/profile/views/screens/edit_profile.dart';
import 'package:mdc_card/moduls/profile/views/screens/language.dart';
import 'package:mdc_card/moduls/profile/views/screens/notification_screen.dart';
import 'package:mdc_card/moduls/profile/views/screens/term_serivice.dart';
import 'package:mdc_card/moduls/profile/views/screens/who_are_we.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0.h,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              statusBarColor: Color(0xffE8E8E8))),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return SafeArea(
          child: Column(children: [
            Expanded(
              flex: 2,
              // child: Container(
              //   color: HexaColor.fromHexa('#E8E8E8'),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16.w),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'login'.tr,
              //           style: TextStyle(fontSize: 20.sp),
              //         ),
              //         SizedBox(
              //           height: 20.h,
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(
              //               height: 44.h,
              //               width: 167.w,
              //               child: ElevatedButton(
              //                 child: Text("login".tr),
              //                 onPressed: () {},
              //               ),
              //             ),
              //             SizedBox(
              //               width: 9.w,
              //             ),
              //             SizedBox(
              //               height: 44.h,
              //               width: 167.w,
              //               child: ElevatedButton(
              //                 style: ElevatedButton.styleFrom(
              //                     primary: HexaColor.fromHexa('#00A19B')),
              //                 child: Text("signUp".tr),
              //                 onPressed: () {},
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // )
              child: Container(
                color: HexaColor.fromHexa('#E8E8E8'),
                child: Center(
                    child: CircleAvatar(
                  radius: 60.w,
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/logomo.jpg'),
                )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  ListTile(
                    onTap: () async {
                      Get.to(EditProfile());
                      await logic.getProfile();
                    },
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: SvgPicture.asset('assets/images/Path 1119.svg')),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "informationAccount".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child:
                            SvgPicture.asset('assets/images/Group 1058.svg')),
                    title: Text(
                      "notification".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(LanguageScreen());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child:
                            SvgPicture.asset('assets/images/Group 1059.svg')),
                    title: Text(
                      "language".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () {
                      launchUrl(Uri.parse("http://app.mdc-card.com//api/about"));
                  //    Get.to(WhoAreWe());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: SvgPicture.asset('assets/images/Path 1126.svg')),
                    title: Text(
                      "whoAreWe".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(ContactUs());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: SvgPicture.asset(
                            'assets/images/noun-support-4831710.svg')),
                    title: Text(
                      "contactUs".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () {
                      launchUrl(Uri.parse("http://app.mdc-card.com//api/policy"));
                    //   Get.to(TermSerivce());
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: SvgPicture.asset('assets/images/Path 1128.svg')),
                    title: Text(
                      "termsofService".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                  ),
                  ListTile(
                    onTap: () async {
                      await logic.logout();
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                        width: 25.w,
                        height: 25.h,
                        child: SvgPicture.asset('assets/images/Path 1130.svg')),
                    title: Text(
                      "logout".tr,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20.w,
                    ),
                  ),
                ]),
              ),
            )
          ]),
        );
      }),
    );
  }
}
