import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/profile/controller/profile_controller.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WhoAreWe extends StatelessWidget {
  const WhoAreWe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("whoAreWe".tr),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //     Center(
      //         child: SvgPicture.asset(
      //       'assets/images/Path 23.svg',
      //       width: 115.w,
      //       height: 110.h,
      //       fit: BoxFit.fill,
      //     )),
      //     SizedBox(
      //       height: 22.h,
      //     ),
      //     Row(
      //       children: [
      //         Text(
      //           'whoAreWe'.tr,
      //           style: TextStyle(
      //               fontSize: 22.sp, color: HexaColor.fromHexa('#00A19B')),
      //         ),
      //         SizedBox(
      //           width: 5.w,
      //         ),
      //         Text(
      //           '!',
      //           style: TextStyle(
      //               fontSize: 22.sp, color: HexaColor.fromHexa('#00A19B')),
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       height: 17.h,
      //     ),
      //     Text(
      //       'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيقن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق',
      //       style: TextStyle(
      //           fontSize: 16.sp, fontWeight: FontWeight.w500, height: 1.5.h),
      //     ),
      //   ]),
      // ),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return WebView(
          initialUrl: 'https://app.mdc-card.com//api/about',
        );
      }),
      //
    );
  }
}
