import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/add_card/card_controller/card_controller.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/offer/views/screens/offers_map_screen.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import '../../../main/controller/main_controller.dart';
import 'details_offers.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  var controller = Get.put(OffersController());

  @override
  void initState() {
    controller. getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "offer".tr,
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
                  : logic.offersModel!.data == null
                      ? Center(
                          child: Image.asset(
                            'assets/images/not-found.png',
                            width: 125.w,
                            height: 125.h,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 16.w),
                                child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (c, i) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 16.0.h, bottom: 8.h),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(13.0),
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    logic.offersModel!.data![i]
                                                        .image!,
                                                    fit: BoxFit.fill,
                                                    // width: 220,
                                                    height: 150.h,
                                                  ),
                                                  SizedBox(
                                                    height: 9.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              logic
                                                                  .offersModel!
                                                                  .data![i]
                                                                  .description!
                                                                  .trim(),
                                                              style: TextStyle(
                                                                  color: HexaColor
                                                                      .fromHexa(
                                                                          '#054769'),
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  logic
                                                                          .offersModel!
                                                                          .data![
                                                                              i]
                                                                          .priceAfter!
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
                                                                          .offersModel!
                                                                          .data![
                                                                              i]
                                                                          .priceBefore!
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
                                                  Row(
                                                    children: [
                                                      (logic
                                                              .offersModel!
                                                              .data![i]
                                                              .offerTaken)
                                                          ? Expanded(
                                                              child: Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/images/icons_ok.svg',
                                                                ),
                                                                SizedBox(
                                                                  width: 03,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'offer_bought_successfully'.tr,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xff054769)),
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                          : Expanded(
                                                              child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            13.0),
                                                                  ))),
                                                                  onPressed: () {
                                                                    CardController()
                                                                        .changePayValue(
                                                                            'visa');
                                                                    logic.takeOffer(
                                                                        context,
                                                                        logic
                                                                            .offersModel!
                                                                            .data![
                                                                                i]
                                                                            .id,
                                                                        logic
                                                                            .offersModel!
                                                                            .data![i]
                                                                            .priceAfter);
                                                                    // logic.takeOffer(logic
                                                                    //     .offersModel!.data![i].id);
                                                                    // showTakeOfferMessage(
                                                                    //     context,
                                                                    //     logic
                                                                    //         .takeOfferModel!.message);
                                                                  },
                                                                  child: Text(
                                                                    'takeOffer'
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      ElevatedButton(
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
                                                          onPressed: () async {
                                                            print(
                                                                'logic.offersModel!.data![i].id');
                                                            print(logic
                                                                .offersModel!
                                                                .data![i]
                                                                .id);
                                                            await logic
                                                                .getDetailsOffer(
                                                                    logic
                                                                        .offersModel!
                                                                        .data![
                                                                            i]
                                                                        .id!);

                                                            Get.to(() => DetailsOffer(
                                                                offerTaken: logic
                                                                    .offersModel!
                                                                    .data![i]
                                                                    .offerTaken));
                                                          },
                                                          child: Text(
                                                            'details'.tr,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xff00416B),
                                                                fontSize: 15),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (c, i) {
                                      return Column(
                                        children: [
                                          Divider(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: logic.offersModel!.data!.length),
                              ),
                            ),
                            Container(
                              height: 40.h,
                              color: Colors.transparent,
                            ),
                          ],
                        );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await OffersController().getCurrentLocation();
          Get.to(() => OffersMapScreen());
        },
        child: Icon(
          Icons.map_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  showTakeOfferMessage(context, message) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff00416B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            content: Container(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          );
        });
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pop();
  }
}
