import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/offer/views/screens/details_offer.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import '../../../main/controller/main_controller.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  var controller = Get.put(OffersController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexaColor.fromHexa('#00416B'),
        ),
        backgroundColor: HexaColor.fromHexa('#00416B'),
        title: Text("offer".tr),
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  FilterOffer(),
                  isScrollControlled: true,
                );
              },
              icon: SvgPicture.asset('assets/images/Path 1087.svg'))
        ],
      ),
      body: GetBuilder<OffersController>(builder: (logic) {
        return logic.isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : logic.offersModel!.data == null
                ? Center(
                    child: Image.asset(
                      'assets/images/not-found.png',
                      width: 125.w,
                      height: 125.h,
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (c, i) {
                          return GestureDetector(
                              onTap: () async {
                                Get.to(DetailsOffer());
                                await logic.getDetailsOffer(
                                    logic.offersModel!.data![i].id!);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 16.0.h, bottom: 8.h),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        logic.offersModel!.data![i].logo!,
                                        fit: BoxFit.fill,
                                        width: 90.w,
                                        height: 90.h,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              logic.offersModel!.data![i].name!,
                                            ),
                                            SizedBox(
                                              height: 18.h,
                                            ),
                                            Text(
                                              logic.offersModel!.data![i]
                                                  .description!
                                                  .trim(),
                                              style: TextStyle(
                                                  color: HexaColor.fromHexa(
                                                      '#707070'),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                        separatorBuilder: (c, i) {
                          return Column(
                            children: [
                              Divider(
                                height: 1.h,
                              ),
                            ],
                          );
                        },
                        itemCount: logic.offersModel!.data!.length),
                  );
      }),
    );
  }
}

class FilterOffer extends StatelessWidget {
  const FilterOffer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return GetBuilder<MainController>(builder: (logic) {
        return SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                            logic.checked =
                                logic.checked.map((e) => e = false).toList();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.w,
                            color: Colors.white,
                          )),
                      Text(
                        "filter".tr,
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                      Container(),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ListView.separated(
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              logic.changeCheck(
                                i,
                                logic.cityModel!.data!.cityList![i].name!,
                              );
                            },
                            child: Container(
                              width: 100.w,
                              alignment: Alignment.center,
                              height: 44.h,
                              decoration: BoxDecoration(
                                  color: logic.checked[i]
                                      ? HexaColor.fromHexa('#00A19B')
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                logic.cityModel!.data!.cityList![i].name!,
                                style: TextStyle(
                                    color: logic.checked[i]
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: logic.cityModel!.data!.cityList!.length),
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
                      child: Text("filter".tr),
                      onPressed: () async {
                        logic.checked =
                            logic.checked.map((e) => e = false).toList();
                        var controller = Get.put(OffersController());
                        await controller.getDirectoryFilter(logic.filterText!);
                        logic.textFilter = [];
                        logic.filterText = "";
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
