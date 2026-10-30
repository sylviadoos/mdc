import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/main/views/search_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/offer/views/screens/details_services.dart';
import 'package:mdc_card/moduls/offer/views/screens/services_screen.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/constant.dart';
import '../../../offer/views/screens/details_offers.dart';
import '../../../offer/views/screens/details_services.dart';
import '../../../offer/views/screens/offers_screen.dart';
import 'MoreFilters.dart';
import 'heart_beats.dart';
// import '../../../offer/views/screens/offers_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('userId' + userId.toString());
    return Scaffold(
      backgroundColor: HexaColor.fromHexa('#F5F5F5'),
      body: GetBuilder<MainController>(builder: (logic) {
        return logic.isLoadingHome
            ? Container(
            height: double.infinity,
            child: Center(
                child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .primaryColor,
                )))
            : SingleChildScrollView(
            child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: Get.width,padding: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(Colors.transparent.withOpacity(.6), BlendMode.dstATop),

                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/images/${countryCode!.replaceAll("+", "")}.png'),
                        ),
                      ),                      child: Stack(
                      clipBehavior: Clip.none,
                      children: [

                        // child:

                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Center(
                                child: Text(
                                  "home".tr,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    logic.onItemTapped(1);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 10,bottom: 15),
                                    child: Column(
                                      children: [
                                        Container(width: 80.0.w,height: 80.0.w,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                                color: Colors.black, offset: Offset(1, 1), blurRadius: 5)
                                          ],
                                            borderRadius: BorderRadius.circular(70),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                "assets/images/requestimage.jpg",),
                                            ),),

                                        ),  SizedBox(height: 5,),   Center(child: Text('Request Card',style: TextStyle(shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                          ),

                                        ],color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(HeartBeats());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 10,bottom: 15),
                                    child: Column(
                                      children: [
                                        Container(width: 80.0.w,height: 80.0.w,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                                color: Colors.black, offset: Offset(1, 1), blurRadius: 5)
                                          ],
                                            borderRadius: BorderRadius.circular(70),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                "assets/images/heart_beat.png",),
                                            ),),

                                        ),  SizedBox(height: 5,), Center(child: Text('Heart rate',style: TextStyle(shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                          ),

                                        ],color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 10),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: GestureDetector(
                              onTap: () async {
                                // logic.serach();

                                Get.to(SearchScreen());
                                await logic.getOffers();

                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                    ),
                    //
                    Container(

                      width: double.infinity,
                      height: 140.69.h,
                      child: CarouselSlider.builder(
                        itemCount: logic.homeModel?.data?.offers?.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return GestureDetector(
                            onTap: () async {
                             // Get.to(OfferScreen());
                             //  logic.getOffers();
                             //   Get.to(ServicesScreen());
                              var controller = Get.put(OffersController());
                             //  print(logic
                             //      .homeModel!.data!.offers![index]
                             //      .hospitalId!);
                             //  await controller.getDetailsDirctory(int.parse(
                             //      logic.homeModel!.data!.offers![index]
                             //          .hospitalId!));
                              Get.to(() => DetailsServices());
                              await controller.getDetailsServices(int.parse(
                                  logic.homeModel!.data!.offers![index]
                                      .hospitalId!));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 5.h),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                width: double.infinity,
                                child: GFImageOverlay(
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(.05),
                                        BlendMode.color),
                                    borderRadius: BorderRadius.circular(20),
                                    image: NetworkImage(logic.homeModel!.data!
                                        .offers![index].image!)),
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
                        color: Theme
                            .of(context)
                            .primaryColor,
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
                                      Get.to(SearchScreen());
                                      //    logic.onItemTapped(2);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'more'.tr,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: HexaColor.fromHexa(
                                                  '#999999')
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                          color: HexaColor.fromHexa(
                                              '#999999'),
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
                                child:logic.homeModel!.data!.latestOffers!.length ==0 ? Column(
                                  children: [
                                    Image.asset('assets/images/zerostate_offer.png',width: 70,height: 50,),
                                    SizedBox(height: 10.h,),
                                    InkWell(child: Text('Show all services in you country'.tr,style: TextStyle(
                                      color: Color(0xa14f4f4f).withOpacity(.4),fontSize: 12,    decoration: TextDecoration.underline,

                                    ),),onTap: (){
                                      logic.filterText = country;

                                      Get.to(() => ServicesScreen());
                                    },)
                                  ],
                                )
                                    :ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        // onTap: () {
                                        //   Get.to(() => OfferScreen());
                                        //   logic.getOffers();
                                        // },
                                        onTap: () async {
                                          Get.to(() => DetailsServices());
                                          var controller =
                                          Get.put(OffersController());
                                          print(logic.homeModel!.data!
                                              .latestOffers![i].id);
                                          // await controller
                                          //     .getDetailsDirctory(logic
                                          //     .homeModel!
                                          //     .data!
                                          //     .latestOffers![i]
                                          //     .hospitalId!);
                                          await controller.getDetailsServices(
                                              logic.homeModel!
                                                  .data!
                                                  .latestOffers![i]
                                                  .hospitalId!);
                                          //  Get.to(() => DetailsServices());

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius
                                                  .circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      logic
                                                          .homeModel!
                                                          .data!
                                                          .latestOffers![
                                                      i]
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
                                    itemCount: logic.homeModel!.data!
                                        .latestOffers!.length),
                              )
                            ],
                          )),
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
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'recentlyJoined'.tr,
                                    style: TextStyle(

                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
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
                                          // Get.to(() => OfferScreen());
                                          // logic.getOffers();
                                          var controller =
                                                Get.put(OffersController());
                                          Get.to(() => DetailsServices());

                                          await controller.getDetailsServices(
                                                logic.homeModel!.data!
                                                    .suppliers![i].hospitalId!);
                                         //   Get.to(DetailsOffer(offerTaken: null,));
                                        },
                                        // onTap: () async {
                                        //   var controller =
                                        //       Get.put(OffersController());
                                        //   await controller.getDetailsDirctory(
                                        //       logic.homeModel!.data!
                                        //           .suppliers![i].hospitalId!);
                                        //   Get.to(DetailsOffer());
                                        // },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          height: 90.h,
                                          width: 90.w,
                                          child: Image.network(
                                            logic.homeModel!.data!
                                                .suppliers![i]
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
                                    itemCount:logic
                                        .homeModel != null ? logic
                                        .homeModel!.data!.suppliers!.length: 0),
                              )
                            ],
                          )),
                    ),

                    SizedBox(
                      height: 32,
                    ),

                    Row(mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0),
                          child: Text(
                            'services'.tr,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                        ), Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0),
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                MoreFilters(),
                                isScrollControlled: true,
                              );
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
                                  color: HexaColor.fromHexa(
                                      '#999999'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // number of items in each row
                          mainAxisSpacing: 5.0,
                          // spacing between rows
                          crossAxisSpacing: 5.0, // spacing between columns
                        ),
                        itemBuilder: (context, index) {
                          List servicesTitles = [
                            Get.locale.toString() == "ar"
                                ? logic.cityModel!.data!.cityList![3].name!
                                .split("-")
                                .last
                                : logic.cityModel!.data!.cityList![3].name!
                                .split("-")
                                .first,
                            Get.locale.toString() == "ar"
                                ? logic.cityModel!.data!.cityList![1].name!
                                .split("-")
                                .first
                                : logic.cityModel!.data!.cityList![1].name!
                                .split("-")
                                .last,
                            Get.locale.toString() == "ar"
                                ? logic.cityModel!.data!.cityList![6].name!
                                .split("-")
                                .last
                                : logic.cityModel!.data!.cityList![6].name!
                                .split("-")
                                .first,
                            Get.locale.toString() == "ar"
                                ? logic.cityModel!.data!.cityList![5].name!
                                .split("-")
                                .last
                                : logic.cityModel!.data!.cityList![5].name!
                                .split("-")
                                .first,
                          ];
                          List servicesTitles_s = [
                            logic.cityModel!.data!.cityList![3].name!,
                            logic.cityModel!.data!.cityList![1].name!,
                            logic.cityModel!.data!.cityList![6].name!,
                            logic.cityModel!.data!.cityList![5].name!
                          ];
                          return GestureDetector(
                            onTap: () {
                              logic.filterText = servicesTitles_s[index];

                              Get.to(() => ServicesScreen());
                              // logic.onItemTapped(2);
                              // Get.bottomSheet(
                              //   FilterOffer(),
                              //   isScrollControlled: true,
                              // );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  servicesImages[index],
                                  width: 45,
                                  height: 43,
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Text(
                                  servicesTitles[index],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff054769)),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 4,
                      ),
                    )
                  ],
                )));
      }),
    );
  }
}
