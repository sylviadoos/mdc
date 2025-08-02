import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';

class UpdateAppVersion extends StatelessWidget {
  const UpdateAppVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/Group 1175.png',
              ),
            )),
            height: 190.h,
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
          Container(
              height: 592.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/Group 1176.png',
                ),
              )),
              child: GetBuilder<AuthController>(builder: (logic) {
                return Form(
                  key: logic.forgetLoginKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        Text(
                          'updateAppVersion'.tr,
                          style:
                              TextStyle(fontSize: 26.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'newVersionAvailableUpdateNow'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16.sp, color: Colors.white),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        SizedBox(
                          height: 44.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                              logic.launchToGooglePlayUrl()
                            ,
                            child: Text("updateNow".tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
        ],
      ))),
    );
  }
}
