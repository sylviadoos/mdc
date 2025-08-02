import 'package:country_picker/country_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:mdc_card/moduls/add_card/views/widgets/pay_widgets.dart';
import 'package:mdc_card/utils/component/component.dart';

import '../../../../utils/themes/light_theme.dart';
import '../../card_controller/card_controller.dart';

class FormCard extends StatefulWidget {
  String? name;
  FormCard({Key? key, required this.name}) : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Request a".tr + " " + "${widget.name}"),
      ),
      body: GetBuilder<CardController>(
        builder: (logic) {
          return Form(
            key: logic.formKey,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                    child: Text('sex'.tr),
                  ),
                  SizedBox(
                    height: 8.h,
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
                            value: 'male',
                            groupValue: logic.groupSex,
                            onChanged: (c) {
                              logic.changSex(c.toString());
                            },
                            activeColor: logic.groupSex == "male"
                                ? HexaColor.fromHexa('#00A19B')
                                : HexaColor.fromHexa('#999999'),
                          ),
                          Text(
                            'Male'.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: logic.groupSex == "male"
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
                            value: 'female',
                            groupValue: logic.groupSex,
                            onChanged: (c) {
                              logic.changSex(c.toString());
                            },
                            activeColor: logic.groupSex == "female"
                                ? HexaColor.fromHexa('#00A19B')
                                : HexaColor.fromHexa('#999999'),
                          ),
                          Text(
                            'Female'.tr,
                            style: TextStyle(
                                color: logic.groupSex == "female"
                                    ? HexaColor.fromHexa('#00A19B')
                                    : HexaColor.fromHexa('#999999')),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 70.h,
                    child: defaultFormField(
                        hintText: "enterFullName".tr,
                        fillColor: HexaColor.fromHexa('#F8F8F8'),
                        controller: logic.name,
                        validate: (s) {
                          if (s!.isEmpty) {
                            return "require".tr;
                          }
                        },
                        borderColor: Colors.transparent,
                        type: TextInputType.text),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: defaultFormField(
                        writeTextColor: Colors.black,
                        writeFontSize: 16.sp,
                        prefix: SizedBox(
                            height: 20.h,
                            width: 30.w,
                            child: const Center(child: Text("+973"))),
                        hintText: "EnterPhone".tr,
                        fillColor: HexaColor.fromHexa('#F8F8F8'),
                        borderColor: Colors.transparent,
                        controller: logic.phone,
                        validate: (s) {
                          // if (!GetUtils.isPhoneNumber(s!.trim())) {
                          //   return "minimum8Digits".tr;
                          // }
                        },
                        type: TextInputType.text),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: defaultFormField(
                        writeTextColor: Colors.black,
                        writeFontSize: 16.sp,
                        hintText: "enterNamberCPRNo".tr,
                        fillColor: HexaColor.fromHexa('#F8F8F8'),
                        borderColor: Colors.transparent,
                        controller: logic.gcc_id,
                        validate: (s) {
                          if (s!.isEmpty) {
                            return "theCPR/GCCIDFieldIsRequired".tr;
                          }
                        },
                        type: TextInputType.text),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            height: 600.h,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                GFListTile(
                                    padding: EdgeInsets.zero,
                                    title: Text("selectArea".tr),
                                    icon: IconButton(
                                      icon: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Icon(
                                          Icons.clear,
                                          size: 20.w,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    )),
                                Flexible(
                                  child: ListView.separated(
                                      itemBuilder: (c, i) {
                                        return GFListTile(
                                          onTap: () {
                                            logic.onChangeArea(
                                                logic.listArea[i]);
                                            Get.back();
                                          },
                                          padding: EdgeInsets.zero,
                                          title: Text(logic.listArea[i]),
                                        );
                                      },
                                      separatorBuilder: (c, i) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            DottedBorder(
                                              color:
                                                  HexaColor.fromHexa('#E8E8E8'),
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
                                          ],
                                        );
                                      },
                                      itemCount: logic.listArea.length),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.valueArea,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: logic.valueArea != "selectArea".tr
                                    ? Colors.black
                                    : HexaColor.fromHexa('#999999')),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode:
                            false, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          logic.changeNationality(
                              country.displayNameNoCountryCode);
                          print(
                              'Select country: ${country.displayNameNoCountryCode}');
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.nationality == null
                                ? "selectNationality".tr
                                : logic.nationality!,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: logic.nationality != null
                                    ? Colors.black
                                    : HexaColor.fromHexa('#999999')),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            height: 300.h,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                GFListTile(
                                    padding: EdgeInsets.zero,
                                    title: Text("selectTypeCard".tr),
                                    icon: IconButton(
                                      icon: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Icon(
                                          Icons.clear,
                                          size: 20.w,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    )),
                                Flexible(
                                  child: ListView.separated(
                                      itemBuilder: (c, i) {
                                        return GFListTile(
                                          onTap: () {
                                            logic.idCard = logic
                                                .cardTypeModel!.data![i].id!;
                                            logic.changePrice(logic
                                                .cardTypeModel!.data![i].price);
                                            logic.changeSelectTypeCard(logic
                                                .cardTypeModel!.data![i].name!);
                                            Get.back();
                                          },
                                          padding: EdgeInsets.zero,
                                          title: Text(logic
                                              .cardTypeModel!.data![i].name!),
                                        );
                                      },
                                      separatorBuilder: (c, i) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            DottedBorder(
                                              color:
                                                  HexaColor.fromHexa('#E8E8E8'),
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
                                          ],
                                        );
                                      },
                                      itemCount:
                                          logic.cardTypeModel!.data!.length),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.cardType == null
                                ? "selectTypeCard".tr
                                : logic.cardType!,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: logic.cardType != null
                                    ? Colors.black
                                    : HexaColor.fromHexa('#999999')),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await logic.showPicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: HexaColor.fromHexa('#F8F8F8'),
                      ),
                      child: logic.image != null
                          ? Container(
                              height: 44.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(children: [
                                Icon(
                                  Icons.image,
                                  size: 20.w,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 11.w,
                                ),
                                Text(
                                  logic.image!.path
                                      .split('/')
                                      .last
                                      .substring(0, 20),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: HexaColor.fromHexa('#BDBDBD')),
                                )
                              ]),
                            )
                          : Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  "downloadDoc".tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: logic.cardType != null
                                          ? Colors.black
                                          : HexaColor.fromHexa('#999999')),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            height: 300.h,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                GFListTile(
                                    padding: EdgeInsets.zero,
                                    title: Text("choseTypeDoc".tr),
                                    icon: IconButton(
                                      icon: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: Icon(
                                          Icons.clear,
                                          size: 20.w,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    )),
                                Flexible(
                                  child: ListView.separated(
                                      itemBuilder: (c, i) {
                                        return GFListTile(
                                          onTap: () {
                                            logic.idDoc = logic
                                                .documentTypeModel!.data![i].id;
                                            logic.onChangeDoc(logic
                                                .documentTypeModel!
                                                .data![i]
                                                .name!);
                                            Get.back();
                                          },
                                          padding: EdgeInsets.zero,
                                          title: Text(logic.documentTypeModel!
                                              .data![i].name!),
                                        );
                                      },
                                      separatorBuilder: (c, i) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            DottedBorder(
                                              color:
                                                  HexaColor.fromHexa('#E8E8E8'),
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
                                          ],
                                        );
                                      },
                                      itemCount: logic
                                          .documentTypeModel!.data!.length),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.valueDoc == null
                                ? "choseTypeDoc".tr
                                : logic.valueDoc!,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: logic.valueDoc != null
                                    ? Colors.black
                                    : HexaColor.fromHexa('#999999')),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 9.h),
                      width: double.infinity,
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexaColor.fromHexa('#00A19B').withOpacity(.1)),
                      child: Row(
                        children: [
                          Text("price".tr + " :"),
                          SizedBox(
                            width: 12.w,
                          ),
                          Row(
                            children: [
                              Text('BHD',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: HexaColor.fromHexa('#00A19B'),
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                logic.price!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: HexaColor.fromHexa('#00A19B'),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 44.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.bottomSheet(PayChoose());
                      },
                      child: Text("confirmOrder".tr),
                    ),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
