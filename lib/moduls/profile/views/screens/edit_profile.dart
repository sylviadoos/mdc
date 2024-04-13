import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:mdc_card/moduls/profile/controller/profile_controller.dart';

import '../../../../utils/component/component.dart';
import '../../../../utils/themes/light_theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.put(ProfileController());

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("informationAccount".tr),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              statusBarColor: Theme.of(context).primaryColor)),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return logic.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60.w,
                                backgroundColor: Colors.white,
                                child: logic.image == null
                                    ? Image.asset('assets/images/logomo.jpg')
                                    : ClipOval(
                                        child: Image.file(
                                          File(logic.image!.path),
                                          fit: BoxFit.fill,
                                          width: 150.w,
                                          height: 150.h,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  logic.showPicker(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Group 1065.svg',
                                      width: 24.w,
                                      height: 24.h,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      'edit'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.black),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            child: defaultFormField(
                                prefix: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Icon(Icons.person),
                                ),
                                controller: logic.name,
                                hintText: logic.profileModel?.data?.fullname ??
                                    "Ahmed",
                                borderColor: Colors.transparent,
                                fillColor: HexaColor.fromHexa('#F8F8F8'),
                                type: TextInputType.text),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            child: defaultFormField(
                                prefix: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Icon(Icons.email),
                                ),
                                controller: logic.email,
                                hintText: logic.profileModel!.data?.email,
                                borderColor: Colors.transparent,
                                fillColor: HexaColor.fromHexa('#F8F8F8'),
                                type: TextInputType.text),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            child: defaultFormField(
                                prefix: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Icon(Icons.call),
                                ),
                                controller: logic.phone,
                                hintText: logic.profileModel?.data?.phoneNumber,
                                borderColor: Colors.transparent,
                                fillColor: HexaColor.fromHexa('#F8F8F8'),
                                type: TextInputType.text),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(StatefulBuilder(
                                builder: (context, state) {
                                  return Container(
                                    height: 200.h,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      children: [
                                        ListTile(
                                            // padding: EdgeInsets.zero,
                                            title: Text("selectSex".tr),
                                            trailing: IconButton(
                                              icon: CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                child: Icon(
                                                  Icons.clear,color: Colors.white,
                                                  size: 20.w,
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            )),
                                        Flexible(
                                          child: ListView(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  logic.changeGender('Male');
                                                  Get.back();
                                                },
                                                // padding: EdgeInsets.zero,
                                                title: Text("Male".tr),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              DottedBorder(
                                                color: HexaColor.fromHexa(
                                                    '#E8E8E8'),
                                                dashPattern: const [8, 4],
                                                strokeWidth: .5,
                                                customPath: (size) {
                                                  return Path()
                                                    ..moveTo(0, 0)
                                                    ..lineTo(size.width, 0);
                                                },
                                                child: Container(),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  logic.changeGender('Female');

                                                  Get.back();
                                                },
                                                // padding: EdgeInsets.zero,
                                                title: Text("Female".tr),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ), isScrollControlled: true);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 44.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: HexaColor.fromHexa('#F8F8F8'),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/Group 1076.svg',
                                        width: 24.w,
                                        height: 24.h,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        logic.profileModel?.data?.gender == ""
                                            ? "selectSex".tr
                                            : logic.profileModel?.data
                                                    ?.gender ??
                                                "",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                HexaColor.fromHexa('#999999')),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 24.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          GestureDetector(
                            onTap: () => _showDatePicker(context),
                            // onTap: () async {
                            //
                            //   // await DatePicker.showDatePicker(context,
                            //   //     showTitleActions: true,
                            //   //     minTime: DateTime(1940, 3, 5),
                            //   //     maxTime: DateTime.now(),
                            //   //     onChanged: (date) {}, onConfirm: (date) {
                            //   //   print(date.toString().split(" ").first);
                            //   //   logic.changeBirthDay(
                            //   //       date.toString().split(" ").first);
                            //   // },
                            //   //     currentTime: DateTime.now(),
                            //   //     locale: Get.locale.toString() == "ar"
                            //   //         ? LocaleType.ar
                            //   //         : LocaleType.en);
                            // },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: 44.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: HexaColor.fromHexa('#F8F8F8'),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/Path 1144.svg',
                                        fit: BoxFit.none,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        logic.profileModel?.data?.birthDate ==
                                                ""
                                            ? "selectedBirthday".tr
                                            : logic.profileModel?.data
                                                    ?.birthDate ??
                                                "",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                HexaColor.fromHexa('#999999')),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 24.w,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: false,
                                  // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    // logic.changeNationality(
                                    //     country.displayNameNoCountryCode);
                                    print(
                                        'Select country: ${country.displayNameNoCountryCode.split(" ").first}');
                                    logic.changeCountry(country
                                        .displayNameNoCountryCode
                                        .split(" ")
                                        .first);
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: 44.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: HexaColor.fromHexa('#F8F8F8'),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/Path 1148.svg',
                                          width: 20.w,
                                          height: 20.h,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          logic.profileModel?.data?.country ==
                                                  ""
                                              ? "selectNationality".tr
                                              : logic.profileModel?.data
                                                      ?.country ??
                                                  "",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: HexaColor.fromHexa(
                                                  '#999999')),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 20.w,
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 18.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            child: defaultFormField(
                                prefix: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Icon(Icons.location_city),
                                ),
                                controller: logic.city,
                                hintText: logic.profileModel?.data?.city == null
                                    ? "enterCity".tr
                                    : logic.profileModel!.data!.city!,
                                borderColor: Colors.transparent,
                                fillColor: HexaColor.fromHexa('#F8F8F8'),
                                type: TextInputType.text),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            child: defaultFormField(
                                prefix: SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Icon(Icons.location_on_rounded),
                                ),
                                controller: logic.address,
                                hintText:
                                    logic.profileModel!.data?.address == null
                                        ? "enterAddress1".tr
                                        : logic.profileModel!.data!.address!,
                                borderColor: Colors.transparent,
                                fillColor: HexaColor.fromHexa('#F8F8F8'),
                                type: TextInputType.text),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 44.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await logic.changeImage();
                              },
                              child: Text(
                                'save'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 16.sp, color: Colors.white),
                              ),
                            ),
                          )
                        ])),
              );
      }),
    );
  }
}

// Show the modal that contains the CupertinoDatePicker
void _showDatePicker(ctx) {
  String date = '';
  // showCupertinoModalPopup is a built-in function of the cupertino library
  showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
            height: 250,
            color: Color.fromARGB(255, 255, 255, 255),
            child: GetBuilder<ProfileController>(builder: (logic) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        TextButton(
                          onPressed: () {

                            Get.back();
                          },
                          child: Text(
                            'cancel'.tr,
                            style: Theme.of(ctx)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 17.sp, color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print('done');
                            print(date.toString().split(" ").first);
                            logic.changeBirthDay(
                                date.toString().split(" ").first);
                            Get.back();
                          },
                          child: Text(
                            'done'.tr,
                            style: Theme.of(ctx)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 17.sp, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(1940, 3, 5),
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.ymd,
                        onDateTimeChanged: (chosenDate) {
                          date = chosenDate.toString();
                        }),
                  ),
                ],
              );
            }),
          ));
}
