import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/add_card/views/screens/form_card.dart';
import 'package:mdc_card/moduls/profile/views/screens/contact_us.dart';

import '../../../../utils/themes/light_theme.dart';
import '../../card_controller/card_controller.dart';

class OptionCard extends StatefulWidget {
  OptionCard({
    Key? key,
  }) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  var controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      builder: (logic) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 280.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  "optionOrder".tr,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(
              //   "cardType".tr,
              //   style: TextStyle(fontSize: 16.sp),
              // ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        value: 'familyCard',
                        groupValue: logic.groupValue,
                        onChanged: (c) {
                          logic.changeValue(c.toString());
                        },
                        activeColor: logic.groupValue == "familyCard"
                            ? HexaColor.fromHexa('#00A19B')
                            : HexaColor.fromHexa('#999999'),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          logic.changeValue('familyCard');
                        },
                        child: Text(
                          'familyCard'.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: logic.groupValue == "familyCard"
                                ? HexaColor.fromHexa('#00A19B')
                                : HexaColor.fromHexa('#999999'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        value: 'onlyCard',
                        groupValue: logic.groupValue,
                        onChanged: (c) {
                          logic.changeValue(c.toString());
                        },
                        activeColor: logic.groupValue == "onlyCard"
                            ? HexaColor.fromHexa('#00A19B')
                            : HexaColor.fromHexa('#999999'),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          logic.changeValue('onlyCard');
                        },
                        child: Text(
                          'onlyCard'.tr,
                          style: TextStyle(
                              color: logic.groupValue == "onlyCard"
                                  ? HexaColor.fromHexa('#00A19B')
                                  : HexaColor.fromHexa('#999999')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 44.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logic.isApproved
                      ? () {
                          Get.back();
                          print(logic.groupValue);
                          Get.to(FormCard(
                            name: logic.groupValue.tr,
                          ));
                        }
                      : null,
                  child: Text("registerNow".tr),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  height: 44.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexaColor.fromHexa('#00A19B')),
                    onPressed: () {
                      Get.to(ContactUs());
                    },
                    child: Text("contactOurClients".tr),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Checkbox(
                    value: logic.isApproved,
                    onChanged: (v) {
                      logic.changeApproved();
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  InkWell(
                    child: Text(
                      'iHaveReadAndAgreedOnMDC'.tr,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
