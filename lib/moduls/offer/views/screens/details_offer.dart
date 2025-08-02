import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsOffer extends StatefulWidget {
  const DetailsOffer({Key? key}) : super(key: key);
  @override
  State<DetailsOffer> createState() => _DetailsOfferState();
}

class _DetailsOfferState extends State<DetailsOffer>
    with SingleTickerProviderStateMixin {
  late TabController? tapController;
  @override
  initState() {
    super.initState();
    tapController = TabController(initialIndex: 0, length: 2, vsync: this);
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
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 25.w,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70.w,
                              height: 70.h,
                              child: Image.network(
                                logic.detailsOffersModel!.data!.logo!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 14.w,
                            ),
                            Expanded(
                              child: Text(
                                logic.detailsOffersModel!.data!.name!,
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
                              .detailsOffersModel!.data!.sliderImages!.length,
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
                                        .detailsOffersModel!
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
                          Tab(text: 'servicePrice'.tr),
                          Tab(text: 'details'.tr),
                        ],
                        controller: tapController,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                          child: TabBarView(
                        controller: tapController,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: double.infinity,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                              fontSize: 12.sp,
                                              color: Colors.white),
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
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Flexible(
                                child: ListView.separated(
                                    itemBuilder: (c, i) {
                                      return Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  Get.locale.toString() == "en"
                                                      ? logic
                                                          .detailsOffersModel!
                                                          .data!
                                                          .services![i]
                                                          .name!
                                                          .split('-')
                                                          .first
                                                      : logic
                                                          .detailsOffersModel!
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
                                                      .detailsOffersModel!
                                                      .data!
                                                      .services![i]
                                                      .priceAfterDiscount!="0"?   logic
                                                      .detailsOffersModel!
                                                      .data!
                                                      .services![i]
                                                      .priceBeforeDiscount!:"",
                                                  style: TextStyle(
                                                      decoration: logic
                                                          .detailsOffersModel!
                                                          .data!
                                                          .services![i]
                                                          .priceAfterDiscount!="0"? TextDecoration
                                                          .lineThrough:TextDecoration.none,
                                                      fontSize: 14.sp,
                                                      color: HexaColor.fromHexa(
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
                                                      .detailsOffersModel!
                                                      .data!
                                                      .services![i]
                                                      .priceAfterDiscount=="0"?logic.detailsOffersModel!.data!.services![i].priceBeforeDiscount!:logic
                                                      .detailsOffersModel!
                                                      .data!
                                                      .services![i]
                                                      .priceAfterDiscount!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: HexaColor.fromHexa(
                                                          '#00A19B')),
                                                ),
                                              )
                                            ],
                                          ));
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
                                    itemCount: logic.detailsOffersModel!.data!
                                        .services!.length),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                logic.detailsOffersModel!.data!.name!,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                logic.detailsOffersModel!.data!.description!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'appointments'.tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                "${"from".tr}"
                                " ${logic.detailsOffersModel!.data!.startDay!}"
                                "  ${"to".tr}"
                                " ${logic.detailsOffersModel!.data!.endDay}",
                                style: TextStyle(
                                    color: HexaColor.fromHexa('#707070'),
                                    fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                  "${"from".tr}"
                                  " ${logic.detailsOffersModel!.data!.startTime!}"
                                  "  ${"to".tr}"
                                  " ${logic.detailsOffersModel!.data!.endTime}",
                                  style: TextStyle(
                                      color: HexaColor.fromHexa('#707070'),
                                      fontSize: 14.sp)),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "${"closedDay".tr}"
                                " ${logic.detailsOffersModel!.data!.closedDay!}",
                                style: TextStyle(
                                    color: HexaColor.fromHexa('#707070'),
                                    fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "contactInformation".tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${"phone".tr}:",
                                    style: TextStyle(
                                        color: HexaColor.fromHexa('#707070')),
                                  ),
                                  Text(
                                    " ${logic.detailsOffersModel!.data!.phoneNumberCountrycode} ${logic.detailsOffersModel!.data!.phoneNumber}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${"mobeil".tr}: ",
                                    style: TextStyle(
                                        color: HexaColor.fromHexa('#707070')),
                                  ),
                                  Text(
                                    " ${logic.detailsOffersModel!.data!.mobileNumberCountrycode} ${logic.detailsOffersModel!.data!.mobileNumber}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'الموقع',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      logic.detailsOffersModel!.data!.address!,
                                      style: TextStyle(
                                          color: HexaColor.fromHexa('#00A19B'),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await MapsLauncher.launchCoordinates(
                                            double.parse(logic
                                                .detailsOffersModel!
                                                .data!
                                                .addressLattitude!),
                                            double.parse(logic
                                                .detailsOffersModel!
                                                .data!
                                                .addressLongitude!));
                                      },
                                      icon: Icon(
                                        Icons.location_on_rounded,
                                        size: 25.w,
                                        color: HexaColor.fromHexa('#00A19B'),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'contactUs'.tr,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 16.w,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  logic.detailsOffersModel!.data!
                                              .facebookLink !=
                                          ""
                                      ? InkWell(
                                          onTap: () async {
                                            if (await canLaunch(logic
                                                .detailsOffersModel!
                                                .data!
                                                .facebookLink!)) {
                                              await launch(logic
                                                  .detailsOffersModel!
                                                  .data!
                                                  .facebookLink!);
                                            } else {
                                              Get.snackbar(
                                                  'Error', 'Can not launch');
                                            }
                                            // SocialShare.shareFacebookStory(
                                            //     'assets/images/icons8-google-48.png',
                                            //     "#ffffff",
                                            //     "#000000",
                                            //     logic.detailsOffersModel!.data!
                                            //         .facebookLink!);
                                          },
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                HexaColor.fromHexa('#00A19B'),
                                            child: SvgPicture.asset(
                                              'assets/images/Path 1221.svg',
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!
                                              .facebookLink !=
                                          ""
                                      ? SizedBox(
                                          width: 16.w,
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!
                                              .instagramLink !=
                                          ""
                                      ? InkWell(
                                          onTap: () async {
                                            if (await canLaunch(logic
                                                .detailsOffersModel!
                                                .data!
                                                .instagramLink!)) {
                                              await launch(logic
                                                  .detailsOffersModel!
                                                  .data!
                                                  .instagramLink!);
                                            } else {
                                              Get.snackbar(
                                                  'Error', 'Can not launch');
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                HexaColor.fromHexa('#00A19B'),
                                            child: SvgPicture.asset(
                                              'assets/images/insta.svg',
                                              width: 24.w,
                                              height: 24.h,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!
                                              .instagramLink! !=
                                          ""
                                      ? SizedBox(
                                          width: 16.w,
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!.twitterLink !=
                                          ""
                                      ? InkWell(
                                          onTap: () async {
                                            if (await canLaunch(logic
                                                .detailsOffersModel!
                                                .data!
                                                .facebookLink!)) {
                                              await launch(logic
                                                  .detailsOffersModel!
                                                  .data!
                                                  .twitterLink!);
                                            } else {
                                              Get.snackbar(
                                                  'Error', 'Can not launch');
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                HexaColor.fromHexa('#00A19B'),
                                            child: SvgPicture.asset(
                                              'assets/images/twitter.svg',
                                              width: 24.w,
                                              height: 24.h,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!.twitterLink !=
                                          ""
                                      ? SizedBox(
                                          width: 16.w,
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!.dribbleLink !=
                                              "" &&
                                          logic.detailsOffersModel!.data!
                                                  .dribbleLink !=
                                              null
                                      ? InkWell(
                                          onTap: () async {
                                            print(logic.detailsOffersModel!
                                                .data!.dribbleLink);
                                            if (await canLaunch(logic
                                                .detailsOffersModel!
                                                .data!
                                                .dribbleLink!)) {
                                              await launch(logic
                                                  .detailsOffersModel!
                                                  .data!
                                                  .dribbleLink!);
                                            } else {
                                              Get.snackbar(
                                                  'Error', 'Can not launch');
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor:
                                                HexaColor.fromHexa('#00A19B'),
                                            child: SvgPicture.asset(
                                              'assets/images/Group 1030.svg',
                                              width: 24.w,
                                              height: 24.h,
                                              fit: BoxFit.fill,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  logic.detailsOffersModel!.data!.dribbleLink !=
                                              "" ||
                                          logic.detailsOffersModel!.data!
                                                  .dribbleLink !=
                                              null
                                      ? SizedBox(
                                          width: 16.w,
                                        )
                                      : Container(),
                                  InkWell(
                                    onTap: () async {
                                      String number =
                                          "${logic.detailsOffersModel!.data!.mobileNumberCountrycode}${logic.detailsOffersModel!.data!.phoneNumber}";
                                      String url =
                                          "https://wa.me/$number?text=Hello";
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        Get.snackbar('Error', 'Can not launch');
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor:
                                          HexaColor.fromHexa('#00A19B'),
                                      child: SvgPicture.asset(
                                        'assets/images/whatsapp.svg',
                                        width: 24.w,
                                        height: 24.h,
                                        fit: BoxFit.fill,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ))
                    ],
                  ),
                ),
        );
      }),
    );
  }
}
