import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/offer/views/screens/details_services.dart';
import 'package:mdc_card/moduls/offer/views/screens/offers_map_screen.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import '../../../add_card/card_controller/card_controller.dart';
import '../../../main/controller/main_controller.dart';

class MyOffersScreen extends StatefulWidget {
  MyOffersScreen({Key? key}) : super(key: key);

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  var controller = Get.put(OffersController());

  @override
  void initState() {
    super.initState();
  }

  List<String> servicesImages = [
    'assets/images/hospital_home.png',
    'assets/images/medical.png',
    'assets/images/pharmacy.png',
    'assets/images/optical.png',
  ];

  @override
  Widget build(BuildContext context) {
    controller.getOffers();
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          toolbarHeight: 0.h,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              statusBarColor: Color(0xff054769))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SafeArea(
            child: Container(
              width: Get.width,
              height: Get.height * 0.14,
              decoration: BoxDecoration(
                // borderRadius:
                //     BorderRadius.only(bottomRight: Radius.circular(30.0)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/circularAppBar.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "my_offer".tr,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<OffersController>(builder: (logic) {
              return logic.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : logic.allUserOffersMain!.data == null
                      ? Center(
                          child: Image.asset(
                            'assets/images/not-found.png',
                            width: 125.w,
                            height: 125.h,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 16.w),
                          child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (c, i) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          logic.allUserOffersMain!.data![i]
                                              .logo!,
                                          fit: BoxFit.fill,
                                          // width: 220,
                                          height: 100.h,
                                        ),
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // SizedBox(
                                              //   height: 9.h,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          logic
                                                              .allUserOffersMain!
                                                              .data![i]
                                                              .name!
                                                              ,
                                                          style: TextStyle(
                                                              color: HexaColor
                                                                  .fromHexa(
                                                                      '#054769'),
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text(
                                                          logic
                                                              .allUserOffersMain!
                                                              .data![i]
                                                              .hospitalName!
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      5,
                                                                      71,
                                                                      105,
                                                                      0.65),
                                                              // color: HexaColor
                                                              //     .fromHexa(
                                                              //         '#707070'),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              logic
                                                                      .allUserOffersMain!
                                                                      .data![i]
                                                                      .priceAfterdis!
                                                                      .toString() +
                                                                  " L.E",
                                                              style: TextStyle(
                                                                  color: HexaColor
                                                                      .fromHexa(
                                                                          '#01AEA8'),
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              width: 50.w,
                                                            ),
                                                            Text(
                                                              logic
                                                                      .allUserOffersMain!
                                                                      .data![i]
                                                                      .priceBeforeDis!
                                                                      .toString() +
                                                                  " L.E",
                                                              style: TextStyle(
                                                                  color: HexaColor
                                                                      .fromHexa(
                                                                          '#054769'),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              logic.allUserOffersMain!.data![i]
                                                          .status ==
                                                      0
                                                  ? ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                          Colors
                                                              .white),
                                                      shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  13.0),
                                                              side:
                                                              BorderSide(
                                                                color: const Color(
                                                                    0xff00416B),
                                                              )))),
                                                      onPressed: () {
                                                        logic
                                                            .useOfferInHospital(
                                                          context,
                                                          logic
                                                              .allUserOffersMain!
                                                              .data![i]
                                                              .id,
                                                        );
                                                      },
                                                      child: Text(
                                                        'use_offer'.tr,
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff00416B),
                                                            fontSize: 15),
                                                      ))
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                // return GestureDetector(
                                //     // onTap: () async {
                                //     //   Get.to(() => DetailsServices());
                                //     //   await logic.getDetailsServices(
                                //     //       logic.allUserOffersMain!.data![i].id!);
                                //     // },
                                //     child: Card(
                                //   elevation: 0,
                                //   color: Colors.white,
                                //   child: Padding(
                                //     padding: EdgeInsets.only(
                                //         top: 16.0.h, bottom: 8.h),
                                //     child: SizedBox(
                                //       width: double.infinity,
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Image.network(
                                //             logic.allUserOffersMain!.data![i]
                                //                 .logo!,
                                //             fit: BoxFit.fill,
                                //             width: 90.w,
                                //             height: 90.h,
                                //           ),
                                //           SizedBox(
                                //             width: 14.w,
                                //           ),
                                //           Expanded(
                                //             child: Row(
                                //               children: [
                                //                 Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment.start,
                                //                   children: [
                                //                     Text(
                                //                       logic.allUserOffersMain!
                                //                           .data![i].name!
                                //                           .toString(),
                                //                       style: TextStyle(
                                //                           color: Color(0xff054769)),
                                //                     ),
                                //                     SizedBox(
                                //                       height: 18.h,
                                //                     ),
                                //                     Text(
                                //                       logic.allUserOffersMain!
                                //                           .data![i].description!
                                //                           .toString(),
                                //                       style: TextStyle(
                                //                           color: Color.fromRGBO(
                                //                               5, 71, 105, 0.65),
                                //                           // color: HexaColor
                                //                           //     .fromHexa(
                                //                           //         '#707070'),
                                //                           fontSize: 14.sp,
                                //                           fontWeight:
                                //                               FontWeight.w400),
                                //                     ),
                                //                     SizedBox(
                                //                       height: 18.h,
                                //                     ),
                                //                     Text(
                                //                       logic.allUserOffersMain!
                                //                           .data![i].hospitalName!
                                //                           .toString(),
                                //                       style: TextStyle(
                                //                           color: Color.fromRGBO(
                                //                               5, 71, 105, 0.65),
                                //                           // color: HexaColor
                                //                           //     .fromHexa(
                                //                           //         '#707070'),
                                //                           fontSize: 14.sp,
                                //                           fontWeight:
                                //                               FontWeight.w400),
                                //                     ),
                                //                     logic.allUserOffersMain!
                                //                                 .data![i].status ==
                                //                             0
                                //                         ? ElevatedButton(
                                //                             style: ButtonStyle(
                                //                                 shape: MaterialStateProperty.all<
                                //                                         RoundedRectangleBorder>(
                                //                                     RoundedRectangleBorder(
                                //                               borderRadius:
                                //                                   BorderRadius
                                //                                       .circular(
                                //                                           13.0),
                                //                             ))),
                                //                             onPressed: () {
                                //                               logic
                                //                                   .useOfferInHospital(
                                //                                 context,
                                //                                 logic
                                //                                     .allUserOffersMain!
                                //                                     .data![i]
                                //                                     .id,
                                //                               );
                                //                             },
                                //                             child: Text(
                                //                               'use_offer'.tr,
                                //                               style: TextStyle(
                                //                                   color:
                                //                                       Colors.white),
                                //                             ))
                                //                         : Container()
                                //                   ],
                                //                 ),
                                //                 Column(children: [
                                //                   Text(
                                //                     logic.allUserOffersMain!.data!
                                //                         [i].priceAfterdis!
                                //                         .toString(),
                                //                     style: TextStyle(
                                //                         fontWeight: FontWeight.w700,
                                //                         fontSize: 20,
                                //                         color: Color(0xff01AEA8)),
                                //                   ),
                                //                   SizedBox(
                                //                     height: 15.h,
                                //                   ),
                                //                   Text(
                                //                     logic.allUserOffersMain!.data![i]
                                //                         .priceBeforeDis!
                                //                         .toString(),
                                //                     style: TextStyle(
                                //                         fontSize: 16.sp,
                                //                         decoration:
                                //                         TextDecoration.lineThrough,
                                //                         color: Color(0xff054769),
                                //                         fontWeight: FontWeight.w500),
                                //                   ),
                                //                 ],)
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ));
                              },
                              separatorBuilder: (c, i) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                );
                              },
                              itemCount: logic.allUserOffersMain!.data!.length),
                        );
            }),
          ),
        ],
      ),
    );
  }
}

List<String> filterImages = [
  'assets/images/physical-therapy.png',
  'assets/images/center.png',
  'assets/images/physical-therapy.png',
  'assets/images/hospital.png',
  'assets/images/microscope.png',
  'assets/images/vision.png',
  'assets/images/pill.png',
  'assets/images/turkey.png',
  'assets/images/oman.png',
  'assets/images/jordan.png',
  'assets/images/travel-insurance.png',
  'assets/images/house.png',

];
List<String> servicesImages = [
  'assets/images/hospital_home.png',
  'assets/images/medical.png',
  'assets/images/pharmacy.png',
  'assets/images/optical.png',
];

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
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 38.h,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
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
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Flexible(
                            child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // number of items in each row
                            mainAxisSpacing: 40.0,
                            // spacing between rows
                            crossAxisSpacing: 10.0, // spacing between columns
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: logic.checked[index]
                                          ? HexaColor.fromHexa('#00A19B')
                                          : Colors.white,
                                      width: 1.7),
                                  borderRadius: BorderRadius.circular(35)),
                              child: GestureDetector(
                                onTap: () {
                                  logic.changeCheck(
                                    index,
                                    logic.cityModel!.data!.cityList![index]
                                        .name!,
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      filterImages[index],
                                      width: 45,
                                      height: 43,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      logic.cityModel!.data!.cityList![index]
                                          .name!,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: logic.cityModel!.data!.cityList!.length,
                        )),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 44.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexaColor.fromHexa('#00A19B')),
                            child: Text(
                              "filter".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              logic.checked =
                                  logic.checked.map((e) => e = false).toList();
                              var controller = Get.put(OffersController());
                              await controller
                                  .getDirectoryFilter(logic.filterText!);
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
              ],
            ),
          ),
        );
      });
    });
  }
}
