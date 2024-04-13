import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';
import 'package:mdc_card/moduls/auth/view/screen/login.dart';

import '../../../../utils/component/component.dart';
import '../../../../utils/themes/light_theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              statusBarColor: Theme.of(context).primaryColor)),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/Group 1175.png',
              ),
            )),
            height: 150.h,
            width: double.infinity,
            child: Center(
                child: SizedBox(
                    width: 80.w,
                    height: 100.h,
                    child: SvgPicture.asset(
                      'assets/images/Layer .svg',
                      fit: BoxFit.none,
                    ))),
          ),
          GetBuilder<AuthController>(builder: (logic) {
            return Form(
              key: logic.formKey,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/Group 1176.png',
                    ),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'signUp'.tr,
                          style:
                              TextStyle(fontSize: 26.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'fullName'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        defaultFormField(
                            validate: (s) {
                              if (s!.isNotEmpty) {
                              } else {
                                return "enterNameCorrect".tr;
                              }
                            },
                            writeTextColor: Colors.white,
                            prefix: Icon(
                              Icons.person,
                              color: HexaColor.fromHexa('#E8E8E8'),
                            ),
                            hintText: 'enterFullName'.tr,
                            hintStyle: TextStyle(
                                color: HexaColor.fromHexa(
                                  '#E8E8E8',
                                ),
                                fontSize: 16.sp),
                            borderColor: Colors.transparent,
                            fillColor:
                                HexaColor.fromHexa('#919191').withOpacity(.5),
                            type: TextInputType.text,
                            controller: logic.name),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'email'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        defaultFormField(
                            validate: (s) {
                              if (GetUtils.isEmail(s!)) {
                              } else {
                                return "enterEmailCorrect".tr;
                              }
                            },
                            writeTextColor: Colors.white,
                            cursorColor: Colors.white,
                            prefix: Icon(
                              Icons.email,
                              color: HexaColor.fromHexa('#E8E8E8'),
                            ),
                            hintText: 'enterEmail'.tr,
                            hintStyle: TextStyle(
                                color: HexaColor.fromHexa(
                                  '#E8E8E8',
                                ),
                                fontSize: 16.sp),
                            borderColor: Colors.transparent,
                            fillColor:
                                HexaColor.fromHexa('#919191').withOpacity(.5),
                            type: TextInputType.text,
                            controller: logic.email),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'phone'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        defaultFormField(
                            validate: (s) {
                              if (s != null) {
                              } else {
                                return "enterPhoneCorrect".tr;
                              }
                            },
                            writeTextColor: Colors.white,
                            cursorColor: Colors.white,
                            prefix: Icon(
                              Icons.phone,
                              color: HexaColor.fromHexa('#E8E8E8'),
                            ),
                            hintText: 'EnterPhone'.tr,
                            hintStyle: TextStyle(
                                color: HexaColor.fromHexa(
                                  '#E8E8E8',
                                ),
                                fontSize: 16.sp),
                            borderColor: Colors.transparent,
                            fillColor:
                                HexaColor.fromHexa('#919191').withOpacity(.5),
                            type: TextInputType.phone,
                            controller: logic.phone),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'password'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        defaultFormField(
                            validate: (s) {
                              if (s!.trim().length >= 6) {
                              } else {
                                return "enterNameCorrect".tr;
                              }
                            },
                            writeTextColor: Colors.white,
                            suffix: Icon(
                              logic.isPassword
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              color: HexaColor.fromHexa('#E8E8E8'),
                            ),
                            prefix: SvgPicture.asset(
                                'assets/images/Path 1138.svg',
                                height: 18.h,
                                width: 16.w,
                                fit: BoxFit.none,
                                color: HexaColor.fromHexa('#E8E8E8')),
                            hintText: 'enterPassword'.tr,
                            hintStyle: TextStyle(
                                color: HexaColor.fromHexa(
                                  '#E8E8E8',
                                ),
                                fontSize: 16.sp),
                            borderColor: Colors.transparent,
                            fillColor:
                                HexaColor.fromHexa('#919191').withOpacity(.5),
                            type: TextInputType.text,
                            controller: logic.password),
                        SizedBox(
                          height: 28.h,
                        ),
                        SizedBox(
                          height: 44.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              logic.signup(context);
                            },
                            child: Text(
                              "signUp".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        logic.isLoading
                            ? SizedBox(
                                height: 15.h,
                              )
                            : Container(),
                        logic.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : Container(),
                        Row(
                          children: [
                            Text(
                              'haveAccount'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.off(() => LoginScreen());
                                },
                                child: Text(
                                  'login'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.white),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          })
        ],
      ))),
    );
  }
}
