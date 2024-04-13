import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:mdc_card/utils/component/component.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import '../../controller/profile_controller.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("contactUs".tr),
      ),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return SingleChildScrollView(
          child: Form(
            key: logic.keyContact,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/NoPath - Copy (2).png',
                        width: double.infinity,
                        height: 217.h,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'contactUs'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp,

                                  fontWeight: FontWeight.w700,
                                  color: HexaColor.fromHexa('#00A19B')),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Center(
                                child: Text(
                                  '+97366903009',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: HexaColor.fromHexa('#707070')),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      height: 0.h,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text('sendWe'.tr),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              value: 'Complains',
                              groupValue: logic.type,
                              onChanged: (c) {
                                logic.changeGroupValue(c.toString());
                                setState(() {});
                              },
                              activeColor: logic.type == 'Complains'
                                  ? HexaColor.fromHexa('#00A19B')
                                  : HexaColor.fromHexa('#999999'),
                            ),
                            Text(
                              'complaint'.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: logic.type == "Complains"
                                    ? HexaColor.fromHexa('#00A19B')
                                    : HexaColor.fromHexa('#999999'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Row(
                          children: [
                            Radio(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              value: 'GeneralInquiry',
                              groupValue: logic.type,
                              onChanged: (c) {
                                logic.changeGroupValue(c.toString());
                                setState(() {});
                              },
                              activeColor: logic.type == "GeneralInquiry"
                                  ? HexaColor.fromHexa('#00A19B')
                                  : HexaColor.fromHexa('#999999'),
                            ),
                            Text(
                              'generalQuestions'.tr,
                              style: TextStyle(
                                  color: logic.type == "GeneralInquiry"
                                      ? HexaColor.fromHexa('#00A19B')
                                      : HexaColor.fromHexa('#999999')),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 44.h,
                      child: defaultFormField(
                          prefix: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Icon(Icons.person),
                          ),
                          controller: logic.fullName,
                          onChange: (c) {
                            logic.update();
                          },
                          hintText: "enterFullName".tr,
                          validate: (v) {
                            if (v!.isEmpty) {
                              lang == "en" ? "required" : "مطلوب";
                            }
                          },
                          borderColor: Colors.transparent,
                          fillColor: HexaColor.fromHexa('#F8F8F8'),
                          type: TextInputType.text),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 44.h,
                      child: defaultFormField(
                          prefix: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Icon(Icons.email),
                          ),
                          controller: logic.emailContact,
                          validate: (v) {
                            if (v!.isEmpty) {
                              lang == "en" ? "required" : "مطلوب";
                            }
                          },
                          hintText: "enterEmail".tr,
                          borderColor: Colors.transparent,
                          onChange: (c) {
                            logic.update();
                          },
                          fillColor: HexaColor.fromHexa('#F8F8F8'),
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      height: 44.h,
                      child: defaultFormField(
                          validate: (v) {
                            if (v!.isEmpty) {
                              lang == "en" ? "required" : "مطلوب";
                            }
                          },
                          onChange: (c) {
                            logic.update();
                          },
                          controller: logic.messageContact,
                          hintText: "enterMessageHere".tr,
                          borderColor: Colors.transparent,
                          fillColor: HexaColor.fromHexa('#F8F8F8'),
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    SizedBox(
                      height: 44.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: logic.emailContact!.text.isNotEmpty &&
                            logic.fullName!.text.isNotEmpty &&
                            logic.messageContact!.text.isNotEmpty
                            ? () {
                          logic.contactUs(context);
                        }
                            : null,
                        child: Text("send".tr),
                      ),
                    )
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
