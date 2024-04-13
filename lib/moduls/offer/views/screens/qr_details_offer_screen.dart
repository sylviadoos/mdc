import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mdc_card/moduls/main/views/screens/home_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main/views/screens/main_screen.dart';
import '../components/star_rate.dart';

class QrDetailsOffer extends StatefulWidget {
  const QrDetailsOffer({Key? key}) : super(key: key);

  @override
  State<QrDetailsOffer> createState() => _QrDetailsOfferState();
}

class _QrDetailsOfferState extends State<QrDetailsOffer>
    with SingleTickerProviderStateMixin {
  late TabController? tapController;
  int selectedIdService = 0;

  @override
  initState() {
    super.initState();
    tapController = TabController(initialIndex: 0, length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OffersController>(builder: (logic) {
        return SafeArea(
          child: logic.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('servicesAvailableDiscount'.tr)),
                      SizedBox(
                        height: 35.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              height: 70.h,
                              child: Image.network(
                                logic.detailsServicesModel!.data!.logo!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Expanded(
                              child: Text(
                                logic.detailsServicesModel!.data!.name!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      SizedBox(
                        height: 166.h,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: logic
                              .detailsServicesModel!.data!.sliderImages!.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () async {},
                                child: GFImageOverlay(
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(.05),
                                        BlendMode.color),
                                    borderRadius: BorderRadius.circular(20),
                                    image: NetworkImage(logic
                                        .detailsServicesModel!
                                        .data!
                                        .sliderImages![index]
                                        .image!)),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlayInterval: Duration(seconds: 7),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            viewportFraction: .9,
                            aspectRatio: 2.2,
                            initialPage: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Color(0xff999999),
                        indicatorWeight: 2.w,
                        labelStyle: TextStyle(
                            color: Color(0xff4F4F4F),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: [
                          Tab(text: 'chooseTheServiceYouNeed'.tr),
                          // Tab(text: 'details'.tr),
                        ],
                        controller: tapController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).primaryColor),
                              height: 52.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'service'.tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'beforeDiscount'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      child: Text(
                                        'afterDiscount'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(width: 43,height: 40,color: Colors.transparent,),
                                ],
                              )),
                          SizedBox(
                            height: 15.h,
                          ),
                          Flexible(
                            child: ListView.separated(
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    onTap: () {
                                      if (logic.detailsServicesModel!.data!
                                              .services![i].id !=
                                          null) {
                                        selectedIdService = (logic
                                            .detailsServicesModel!
                                            .data!
                                            .services![i]
                                            .id!);
                                        setState(() {});
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      Get.locale.toString() ==
                                                              "en"
                                                          ? logic
                                                              .detailsServicesModel!
                                                              .data!
                                                              .services![i]
                                                              .name!
                                                              .split('-')
                                                              .first
                                                          : logic
                                                              .detailsServicesModel!
                                                              .data!
                                                              .services![i]
                                                              .name!
                                                              .split('-')
                                                              .last,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      logic
                                                                  .detailsServicesModel!
                                                                  .data!
                                                                  .services![i]
                                                                  .priceAfterDiscount !=
                                                              "0"
                                                          ? logic
                                                              .detailsServicesModel!
                                                              .data!
                                                              .services![i]
                                                              .priceBeforeDiscount!
                                                          : "",
                                                      style: TextStyle(
                                                          decoration: logic
                                                                      .detailsServicesModel!
                                                                      .data!
                                                                      .services![
                                                                          i]
                                                                      .priceAfterDiscount !=
                                                                  "0"
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                          fontSize: 14.sp,
                                                          color: HexaColor
                                                              .fromHexa(
                                                                  '#707070')),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      logic
                                                                  .detailsServicesModel!
                                                                  .data!
                                                                  .services![i]
                                                                  .priceAfterDiscount ==
                                                              "0"
                                                          ? logic
                                                              .detailsServicesModel!
                                                              .data!
                                                              .services![i]
                                                              .priceBeforeDiscount!
                                                          : logic
                                                              .detailsServicesModel!
                                                              .data!
                                                              .services![i]
                                                              .priceAfterDiscount!,
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: HexaColor
                                                              .fromHexa(
                                                                  '#00A19B')),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Stack(
                                            children: [
                                              Checkbox(
                                                value: (selectedIdService ==
                                                    logic.detailsServicesModel!
                                                        .data!.services![i].id),
                                                onChanged: (_) {},
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Positioned(
                                                  right: 14,
                                                  top: 13,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    color: Colors.transparent,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  //
                                },
                                separatorBuilder: (c, i) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  );
                                },
                                itemCount: logic.detailsServicesModel!.data!
                                    .services!.length),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showCancelDialog();
                                },
                                child: Text('cancel'.tr,style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (selectedIdService != 0) {
                                      showSubmitDialog();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'please select your offer.'),
                                              backgroundColor: Colors.red));
                                    }
                                  },
                                  child: Text('takeTheOffer'.tr,style: TextStyle(color: Colors.white),)),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
        );
      }),
    );
  }

  double rating = 0;
  var offerController = Get.put(OffersController());

  showSubmitDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),
            title: Text(
              "Rate Us",
              style: TextStyle(fontSize: 24.0),
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 230,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: StarRating(
                                rating: rating,
                                onRatingChanged: (rate) {
                                  print(rating);
                                  this.rating = rate;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),SizedBox(height: 10.h,),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                        child: GetBuilder<OffersController>(builder: (logic) {
                          return ElevatedButton(
                            onPressed: () async {
                              if (rating != 0) {
                                await offerController
                                    .postSelectedServiceQRCodeAndRate(
                                        selectedIdService,
                                        logic.detailsServicesModel!.data!.id,
                                        rating);

                                if (offerController
                                        .takeAndRateQrOfferModel!.message ==
                                    'You reviewed save Successfully') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(offerController
                                        .takeAndRateQrOfferModel!.message!),
                                    backgroundColor:
                                        HexaColor.fromHexa('#00A19B'),
                                  ));
                                  Get.offAll(() => MainScreen());
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('please rate us.'),
                                        backgroundColor: Colors.red));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              // fixedSize: Size(250, 50),
                            ),
                            child: Text(
                              "Submit",style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Note'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'We hope you find this useful, Thank you for using MDC.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
  showCancelDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10.0,
            ),

            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 150,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Are you sure you want to cancel this offer?' ,style: TextStyle(fontSize: 17),),
                      ),SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                        child: GetBuilder<OffersController>(builder: (logic) {
                          return ElevatedButton(
                            onPressed: () {
                              Get.offAll(() => MainScreen());},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              // fixedSize: Size(250, 50),
                            ),
                            child: Text(
                              "cancel".tr,style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                      ),


                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
