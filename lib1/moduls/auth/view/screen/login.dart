import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';
import 'package:mdc_card/moduls/auth/view/screen/reset_password.dart';
import 'package:mdc_card/moduls/auth/view/screen/signup_screen.dart';

import '../../../../utils/component/component.dart';
import '../../../../utils/themes/light_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
                statusBarColor: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
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
            Flexible(
              child: GetBuilder<AuthController>(builder: (logic) {
                return Form(
                  key: logic.formLoginKey,
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
                              'login'.tr,
                              style: TextStyle(
                                  fontSize: 26.sp, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'email'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 16.sp, color: Colors.white),
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
                                fillColor: HexaColor.fromHexa('#919191')
                                    .withOpacity(.5),
                                type: TextInputType.text,
                                controller: logic.emailLogin),
                            SizedBox(
                              height: 17.h,
                            ),
                            Text(
                              'password'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 16.sp, color: Colors.white),
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
                                maxLines: 1,
                                isPassword: logic.isPassword,
                                writeTextColor: Colors.white,
                                suffix: GestureDetector(
                                  onTap: () {
                                    logic.changeShowPassword();
                                  },
                                  child: Icon(
                                    logic.isPassword
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off,
                                    color: HexaColor.fromHexa('#E8E8E8'),
                                  ),
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
                                fillColor: HexaColor.fromHexa('#919191')
                                    .withOpacity(.5),
                                type: TextInputType.text,
                                controller: logic.passwordLogin),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(() => ResetPassword());
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'forgetPassword'.tr,
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              height: 19.h,
                            ),
                            SizedBox(
                              height: 44.h,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  logic.login(context);
                                  // Get.to(() => MainScreen());
                                },
                                child: Text("login".tr,style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                              child: Text(
                                'or'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await logic.loginGoogle(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                      child: SizedBox(
                                        height: 22.h,
                                        width: 22.w,
                                        child: Image.asset(
                                          'assets/images/icons8-google-48.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      logic.loginFacebook(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                      child: SizedBox(
                                        height: 20.h,
                                        width: 18.w,
                                        child: SvgPicture.asset(
                                            'assets/images/Path 1221.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                          !  Platform   .isIOS?Container():   InkWell(
                                    onTap: (){
                                      logic.loginApple(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                      child: SizedBox(
                                        height: 20.h,
                                        width: 18.w,
                                        child: SvgPicture.asset(
                                            'assets/images/Path 1220.svg'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'notAccount'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.to(() => SignUpScreen());
                                    },
                                    child: Text(
                                      'signUp'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.white),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              }),
            )
          ],
        )));
  }
}
