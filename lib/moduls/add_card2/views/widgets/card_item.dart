import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mdc_card/moduls/add_card/models/card_model.dart';

import '../../../../shared/constant.dart';
import '../../../../utils/themes/light_theme.dart';

class CardItem extends StatelessWidget {
  DataCards? dataCards;
  CardItem({
    required this.dataCards,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(11.0),
      child: Container(
        height: 185.h,
        width: 300.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/card.png"),
            )),
        child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.cente

          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 25.h,
                          width: 78.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                         lang=="en"?"Membership number":  "رقم العضوية",
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                            dataCards!.policy!,
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 78.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                          lang=="en"? "Full Name": "اسم المستفيد",
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                            dataCards!.fullname!,
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 78.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                           lang=="en"?"GccId": "رقم الإثبات",
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                            dataCards!.gccId!,
                            style:
                                TextStyle(fontSize: 8.sp, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 78.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                            lang=="en"?"Expired Date":"تاريخ الانتهاء",
                            style:
                                TextStyle(fontSize: 9.sp, color: Colors.white),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: HexaColor.fromHexa('#0B646B')),
                          child: Center(
                              child: Text(
                            dataCards!.expiredDate!,
                            style:
                                TextStyle(fontSize: 9.sp, color: Colors.white),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
