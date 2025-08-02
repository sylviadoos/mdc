import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/main/views/search_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/offer/views/screens/details_offer.dart';
import 'package:mdc_card/moduls/offer/views/screens/offers_screen.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexaColor.fromHexa('#F6F6F6'),
      body: GetBuilder<MainController>(builder: (logic) {
        return logic.isLoadingHome?Container(
            height: double.infinity,
            child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))): SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('home'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                  color: Theme.of(context).primaryColor)),
                      SvgPicture.asset('assets/images/Layer 1.svg'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                 // logic.serach();
                  Get.to(SearchScreen());
                },
                child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.0.w,
                          right: 16.w,
                        ),
                        child: SizedBox(
                          height: 40.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexaColor.fromHexa('#F1F4F6'),
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text('search'.tr),
                              )
                            ]),
                          ),
                        ))),
              ),
              //
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 140.69.h,
                child: CarouselSlider.builder(
                  itemCount: logic.homeModel?.data?.offers?.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return GestureDetector(
                      onTap: () async {
                        Get.to(DetailsOffer());
                        var controller = Get.put(OffersController());
                        print(logic.homeModel!.data!.offers![index].hospitalId!);
                        await controller.getDetailsDirctory(
                           int.parse( logic.homeModel!.data!.offers![index].hospitalId!));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5.h),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          child: GFImageOverlay(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(.05),
                                  BlendMode.color),
                              borderRadius: BorderRadius.circular(20),
                              image: NetworkImage(logic
                                  .homeModel!.data!.offers![index].image!)),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    initialPage: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              logic.homeModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 16.h),
                      child: Container(
                          height: 170.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'lastOffers'.tr,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      logic.onItemTapped(2);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'more'.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: HexaColor.fromHexa(
                                                  '#999999')),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                          color: HexaColor.fromHexa('#999999'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18.sp,
                              ),
                              SizedBox(
                                height: 90.h,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () async {
                                          Get.to(DetailsOffer());
                                          var controller =
                                              Get.put(OffersController());
                                          print(logic.homeModel!.data!
                                              .latestOffers![i].id);
                                          await controller.getDetailsDirctory(
                                              logic
                                                  .homeModel!
                                                  .data!
                                                  .latestOffers![i]
                                                  .hospitalId!);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage(logic
                                                      .homeModel!
                                                      .data!
                                                      .latestOffers![i]
                                                      .image!))),
                                          height: 90.h,
                                          width: 90.w,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (c, i) {
                                      return SizedBox(
                                        width: 11.w,
                                      );
                                    },
                                    itemCount: logic
                                        .homeModel!.data!.latestOffers!.length),
                              )
                            ],
                          )),
                    ),
              //
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: SizedBox(
                  height: 44.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    child: Text("RequestAMedicalDiscountCard".tr),
                    onPressed: () {
                      logic.onItemTapped(1);
                    },
                  ),
                ),
              ),

              //
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Container(
                    height: 170.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'recentlyJoined'.tr,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18.sp,
                        ),
                        SizedBox(
                          height: 90.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () async {
                                    var controller =
                                        Get.put(OffersController());
                                    await controller.getDetailsDirctory(logic
                                        .homeModel!
                                        .data!
                                        .suppliers![i]
                                        .hospitalId!);
                                    Get.to(DetailsOffer());
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    height: 90.h,
                                    width: 90.w,
                                    child: Image.network(
                                      logic.homeModel!.data!.suppliers![i]
                                          .image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (c, i) {
                                return SizedBox(
                                  width: 11.w,
                                );
                              },
                              itemCount:
                                  logic.homeModel!.data!.suppliers!.length),
                        )
                      ],
                    )),
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  //height: 210.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 18.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              logic.onItemTapped(2);
                              print(logic.cityModel!.data!.cityList![3].name!);
                              var controller = Get.put(OffersController());
                              Future.delayed(Duration(seconds: 1), () async {
                                await controller.getDirectoryFilter(
                                    logic.cityModel!.data!.cityList![3].name!);
                              });
                            },
                            child: SizedBox(
                                width: 80.w,
                                height: 70.h,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/hosoital.png',
                                      height: 40.h,
                                      width: 40.w,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      Get.locale.toString() == "ar"
                                          ? logic.cityModel!.data!.cityList![3]
                                              .name!
                                              .split("-")
                                              .last
                                          : logic.cityModel!.data!.cityList![3]
                                              .name!
                                              .split("-")
                                              .first,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              logic.onItemTapped(2);
                              print(logic.cityModel!.data!.cityList![1].name!);
                              var controller = Get.put(OffersController());
                              Future.delayed(Duration(seconds: 1), () async {
                                await controller.getDirectoryFilter(
                                    logic.cityModel!.data!.cityList![1].name!);
                              });
                            },
                            child: SizedBox(
                                width: 85.w,
                                height: 70.h,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/hospital-_2_.svg',
                                      height: 33.h,
                                      width: 33.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      Get.locale.toString() == "ar"
                                          ? logic.cityModel!.data!.cityList![1]
                                              .name!
                                              .split("-")
                                              .first
                                          : logic.cityModel!.data!.cityList![1]
                                              .name!
                                              .split("-")
                                              .last,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              logic.onItemTapped(2);
                              print(logic.cityModel!.data!.cityList![5].name!);
                              var controller = Get.put(OffersController());
                              Future.delayed(Duration(seconds: 1), () async {
                                await controller.getDirectoryFilter(
                                    logic.cityModel!.data!.cityList![5].name!);
                              });
                            },
                            child: SizedBox(
                                width: 80.w,
                                height: 70.h,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/opticall.png',
                                      height: 33.h,
                                      width: 33.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      Get.locale.toString() == "ar"
                                          ? logic.cityModel!.data!.cityList![5]
                                              .name!
                                              .split("-")
                                              .last
                                          : logic.cityModel!.data!.cityList![5]
                                              .name!
                                              .split("-")
                                              .first,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () async {
                              logic.onItemTapped(2);
                              print(logic.cityModel!.data!.cityList![6].name!);
                              var controller = Get.put(OffersController());
                              Future.delayed(Duration(seconds: 1), () async {
                                await controller.getDirectoryFilter(
                                    logic.cityModel!.data!.cityList![6].name!);
                              });
                            },
                            child: SizedBox(
                                width: 80.w,
                                height: 70.h,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/drugs.svg',
                                      height: 33.h,
                                      width: 33.w,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      Get.locale.toString() == "ar"
                                          ? logic.cityModel!.data!.cityList![6]
                                              .name!
                                              .split("-")
                                              .last
                                          : logic.cityModel!.data!.cityList![6]
                                              .name!
                                              .split("-")
                                              .first,
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.h,
                      ),
                      Center(
                          child: TextButton(
                              onHover: (s) {
                                print(s);
                              },
                              onPressed: () {
                                logic.onItemTapped(2);
                                Get.bottomSheet(
                                  FilterOffer(),
                                  isScrollControlled: true,
                                );
                              },
                              child: Text('all'.tr))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      }),
    );
  }
}
