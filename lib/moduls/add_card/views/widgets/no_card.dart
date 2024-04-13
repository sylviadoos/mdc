import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NoCard extends StatelessWidget {
  const NoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/images/Group 1047.svg',
              height: 80.2.h,
              width: 100.69.w,
            )),
        SizedBox(
          height: 14.h,
        ),
        Text("don'tAddCard".tr),
        SizedBox(
          height: 28.h,
        ),
      ],
    );
  }
}
