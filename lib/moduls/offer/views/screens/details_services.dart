import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/star_rate.dart';

class DetailsServices extends StatefulWidget {
  const DetailsServices({Key? key}) : super(key: key);

  @override
  State<DetailsServices> createState() => _DetailsServicesState();
}

class _DetailsServicesState extends State<DetailsServices>
    with SingleTickerProviderStateMixin {
  late TabController? tapController;
  int _currentImage = 0;
  CarouselController _imageCarouselController = CarouselController();

  @override
  initState() {
    super.initState();
    tapController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: GetBuilder<OffersController>(builder: (logic) {
        return logic.isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SafeArea(
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 3 - 40,
                      child: CarouselSlider(
                        carouselController: _imageCarouselController,
                        options: CarouselOptions(
                            aspectRatio: 1,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentImage = index;
                              });
                            }),
                        items: logic.detailsServicesModel!
                            .data!.sliderImages!.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                children: <Widget>[
                                  Container(
                                      margin: lang == "ar" ? EdgeInsets.only(right: 27):EdgeInsets.only(left: 27),
                                      decoration: BoxDecoration(
                    
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(i.image!),
                                              fit: BoxFit.cover
                                          )
                                      )
                                  ),
                                  Align(
                                    alignment:lang == "ar"? Alignment.centerRight:Alignment.centerLeft,                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: logic.detailsServicesModel!
                                          .data!.sliderImages!.map((url) {
                                        int index = logic.detailsServicesModel!
                                            .data!.sliderImages!.indexOf(url);
                                        return Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              //print(index);
                                              _imageCarouselController.animateToPage(index,
                                                  curve: Curves.elasticOut
                                              );
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.0, horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                    color:Color.fromRGBO(112, 112, 112, .3),
                                                    width: 1),
                                                //shape: BoxShape.rectangle,
                                              ),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child:
                                                  /*Image.asset(
                                          singleProduct.product_images[index])*/
                                                  FadeInImage.assetNetwork(
                                                    imageErrorBuilder:(context, error, stackTrace) {return Image.asset('assets/images/img.png');},
                                                    placeholder: 'assets/images/img.png',
                                                    image:  url.image!,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 70.w,
                  //         height: 70.h,
                  //         child: Image.network(
                  //           logic.detailsServicesModel!.data!.logo!,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 14.w,
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           logic.detailsServicesModel!.data!.name!,
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               fontSize: 16.sp,
                  //               color: Theme.of(context).primaryColor,
                  //               fontWeight: FontWeight.w600),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 14.h,
                  // ),
                  // SizedBox(
                  //   height: 166.h,
                  //   width: double.infinity,
                  //   child: CarouselSlider.builder(
                  //     itemCount: logic.detailsServicesModel!.data!
                  //         .sliderImages!.length,
                  //     itemBuilder: (BuildContext context, int index,
                  //         int pageViewIndex) {
                  //       return SizedBox(
                  //         width: double.infinity,
                  //         child: GestureDetector(
                  //           onTap: () async {},
                  //           child: GFImageOverlay(
                  //               colorFilter: new ColorFilter.mode(
                  //                   Colors.black.withOpacity(.05),
                  //                   BlendMode.color),
                  //               borderRadius: BorderRadius.circular(20),
                  //               image: NetworkImage(logic
                  //                   .detailsServicesModel!
                  //                   .data!
                  //                   .sliderImages![index]
                  //                   .image!)),
                  //         ),
                  //       );
                  //     },
                  //     options: CarouselOptions(
                  //       autoPlayInterval: Duration(seconds: 7),
                  //       autoPlayAnimationDuration:
                  //           const Duration(milliseconds: 800),
                  //       autoPlayCurve: Curves.fastOutSlowIn,
                  //       enlargeCenterPage: true,
                  //       autoPlay: true,
                  //       viewportFraction: .9,
                  //       aspectRatio: 2.2,
                  //       initialPage: 0,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            surfaceVariant: Colors.transparent,
                          ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color:  Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(0)),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor:  Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.white,
                        indicatorWeight: 2.w,
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            0.0,
                          ),
                          color: Colors.white,
                        ),
                        // indicatorColor: Theme.of(context).primaryColor,
                        tabs: [
                          SizedBox(
                              width: Get.width * 0.5,
                              child: Tab(text: 'servicePrice'.tr)),
                          SizedBox(
                              width: Get.width * 0.5,
                              child: Tab(text: 'details'.tr)),
                          SizedBox(
                              width: Get.width * 0.5,
                              child: Tab(text: 'branches'.tr)),
                        ],
                        controller: tapController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: tapController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'service'.tr,
                                        style: TextStyle(
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff054769)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'beforeDiscount'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff054769)),
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
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff054769)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                              ),

                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (c, i) {
                                      return Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  Get.locale.toString() == "en"
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
                                                      fontSize: 14.sp,color: Color(0xff054769),
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),SizedBox(width: 5,),
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
                                                                  .services![i]
                                                                  .priceAfterDiscount !=
                                                              "0"
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                      fontSize: 20.sp,fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(75, 76, 77, 0.46)),
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
                                                      fontSize: 20.sp,fontWeight: FontWeight.w500,
                                                      color: HexaColor.fromHexa(
                                                          '#01AEA8')),
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
                                    itemCount: logic.detailsServicesModel!.data!
                                        .services!.length),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //         width: double.infinity,
                      //         padding: EdgeInsets.symmetric(horizontal: 10.w),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(12),
                      //             color: Theme.of(context).primaryColor),
                      //         height: 52.h,
                      //         child: Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 3,
                      //               child: Text(
                      //                 'service'.tr,
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 16.sp,
                      //                     fontWeight: FontWeight.w500),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: Text(
                      //                 'beforeDiscount'.tr,
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp, color: Colors.white),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 5.w,
                      //             ),
                      //             Expanded(
                      //               flex: 1,
                      //               child: SizedBox(
                      //                 child: Text(
                      //                   'afterDiscount'.tr,
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                       fontSize: 12.sp,
                      //                       color: Colors.white),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         )),
                      //     SizedBox(
                      //       height: 15.h,
                      //     ),
                      //     Flexible(
                      //       child: ListView.separated(
                      //           itemBuilder: (c, i) {
                      //             return Container(
                      //                 width: double.infinity,
                      //                 padding: EdgeInsets.symmetric(
                      //                     horizontal: 10.w, vertical: 10.h),
                      //                 decoration: BoxDecoration(
                      //                     border: Border.all(
                      //                         color: Theme.of(context)
                      //                             .primaryColor),
                      //                     borderRadius:
                      //                         BorderRadius.circular(12),
                      //                     color: Colors.white),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Expanded(
                      //                       flex: 4,
                      //                       child: Text(
                      //                         Get.locale.toString() == "en"
                      //                             ? logic.detailsServicesModel!
                      //                                 .data!.services![i].name!
                      //                                 .split('-')
                      //                                 .first
                      //                             : logic.detailsServicesModel!
                      //                                 .data!.services![i].name!
                      //                                 .split('-')
                      //                                 .last,
                      //                         style: TextStyle(
                      //                             fontSize: 14.sp,
                      //                             fontWeight: FontWeight.w500),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         logic
                      //                                     .detailsServicesModel!
                      //                                     .data!
                      //                                     .services![i]
                      //                                     .priceAfterDiscount !=
                      //                                 "0"
                      //                             ? logic
                      //                                 .detailsServicesModel!
                      //                                 .data!
                      //                                 .services![i]
                      //                                 .priceBeforeDiscount!
                      //                             : "",
                      //                         style: TextStyle(
                      //                             decoration: logic
                      //                                         .detailsServicesModel!
                      //                                         .data!
                      //                                         .services![i]
                      //                                         .priceAfterDiscount !=
                      //                                     "0"
                      //                                 ? TextDecoration
                      //                                     .lineThrough
                      //                                 : TextDecoration.none,
                      //                             fontSize: 14.sp,
                      //                             color: HexaColor.fromHexa(
                      //                                 '#707070')),
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 10.w,
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Text(
                      //                         logic
                      //                                     .detailsServicesModel!
                      //                                     .data!
                      //                                     .services![i]
                      //                                     .priceAfterDiscount ==
                      //                                 "0"
                      //                             ? logic
                      //                                 .detailsServicesModel!
                      //                                 .data!
                      //                                 .services![i]
                      //                                 .priceBeforeDiscount!
                      //                             : logic
                      //                                 .detailsServicesModel!
                      //                                 .data!
                      //                                 .services![i]
                      //                                 .priceAfterDiscount!,
                      //                         style: TextStyle(
                      //                             fontSize: 16.sp,
                      //                             color: HexaColor.fromHexa(
                      //                                 '#00A19B')),
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ));
                      //             //
                      //           },
                      //           separatorBuilder: (c, i) {
                      //             return Column(
                      //               children: [
                      //                 SizedBox(
                      //                   height: 10.h,
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //           itemCount: logic.detailsServicesModel!.data!
                      //               .services!.length),
                      //     ),
                      //   ],
                      // ),
                      SingleChildScrollView(

                          child: Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)),

                            child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                    child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                    // SizedBox(
                                    //         width: 50.w,
                                    //         height: 50.h,
                                    //         child: Image.network(
                                    //           logic.detailsServicesModel!.data!.logo!,
                                    //           fit: BoxFit.cover,
                                    //         ),
                                    //       ), SizedBox(
                                    //                                 width: 5.w,
                                    //                               ),

                                        SizedBox(
                                          width: 320.w,
                                          child: Text(
                                            logic.detailsServicesModel!.data!.name!,
                                            softWrap: true,
                                            style: TextStyle(

                                                color: Theme.of(context).primaryColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),   SizedBox(
                                      height: 5.h,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        showSubmitDialog();

                                      },
                                      child: RatingBar(
                                        itemSize: 25,
                                        ignoreGestures: true,
                                      initialRating:  double.parse(logic.detailsServicesModel!.data!.rate!),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                      full: Icon(Icons.star, color: Colors.amber),
                                      half: Icon(Icons.star_half, color: Colors.amber),
                                      empty: Icon(Icons.star_border, color: Colors.amber),
                                      ), onRatingUpdate: (double value) {  },),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      logic.detailsServicesModel!.data!
                                          .description!.replaceAll("/", "\n"),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(75, 76, 77, 0.71),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              InkWell(
                                onTap: (){
                                  if(logic.expandedList == 1){
                                    logic.expandedList = 0;

                                  }else{
                                    logic.expandedList = 1;

                                  }
                                  logic.update();
                                },
                                child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/appointments.svg',
                                          height: 19,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'appointments'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),

                                        Expanded(
                                          child: Align(alignment: AlignmentDirectional.topEnd,
                                            child: Icon(
                                              logic.expandedList == 1 ?
                                              Icons.keyboard_arrow_down:
                                              Icons.keyboard_arrow_right,size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              logic.expandedList == 1 ?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      "${"from".tr}"
                                          " ${logic.detailsServicesModel!.data!.startDay!}"
                                          "  ${"to".tr}"
                                          " ${logic.detailsServicesModel!.data!.endDay}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(75, 76, 77, 0.84),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      "${"from".tr}"
                                          " ${logic.detailsServicesModel!.data!.startTime!}"
                                          "  ${"to".tr}"
                                          " ${logic.detailsServicesModel!.data!.endTime}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(75, 76, 77, 0.84),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      "${"closedDay".tr}"
                                          " ${logic.detailsServicesModel!.data!.closedDay!}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(75, 76, 77, 0.84),
                                      ),
                                    ),
                                  ),
                                ],
                              ):Container(),


                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                onTap: (){
                                  if(logic.expandedList == 2){
                                    logic.expandedList = 0;

                                  }else{
                                    logic.expandedList = 2;

                                  }
                                  logic.update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
                                  ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/call.svg',
                                          height: 19,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "contactInformation".tr,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor),
                                        ),

                                        Expanded(
                                          child: Align(alignment: AlignmentDirectional.topEnd,
                                            child: Icon(
                                              logic.expandedList == 2 ?
                                              Icons.keyboard_arrow_down:
                                              Icons.keyboard_arrow_right,size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                              logic.expandedList == 2 ? Column(
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${"phone".tr}:",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                Color.fromRGBO(75, 76, 77, 0.84),
                                              ),
                                            ),
                                            Text(
                                              " ${logic.detailsServicesModel!.data!.phoneNumberCountrycode} ${logic.detailsServicesModel!.data!.phoneNumber}",
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
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                Color.fromRGBO(75, 76, 77, 0.84),
                                              ),
                                            ),
                                            Text(
                                              " ${logic.detailsServicesModel!.data!.mobileNumberCountrycode} ${logic.detailsServicesModel!.data!.mobileNumber}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ) :Container(),

                              SizedBox(
                                height: 20.h,
                              ),
                              InkWell(
                                onTap: (){
                                  if(logic.expandedList == 3){
                                    logic.expandedList = 0;

                                  }else{
                                    logic.expandedList = 3;

                                  }
                                  logic.update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
                                  ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/location.svg',
                                          height: 19,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'location'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor),
                                        ),

                                        Expanded(
                                          child: Align(alignment: AlignmentDirectional.topEnd,
                                            child: Icon(
                                              logic.expandedList == 3 ?
                                              Icons.keyboard_arrow_down:
                                              Icons.keyboard_arrow_right,size: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                              logic.expandedList == 3 ?Column(
                                children: [
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(logic.detailsServicesModel!
                                              .data!.addressLattitude!),
                                          double.parse(logic.detailsServicesModel!
                                              .data!.addressLongitude!));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Text(
                                              logic.detailsServicesModel!.data!
                                                  .address!,
                                              style: TextStyle(
                                                  color:
                                                  HexaColor.fromHexa('#00A19B'),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ):Container(),

                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/contact-us.png',
                                    height: 19,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'contactUs'.tr,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16.w,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    logic.detailsServicesModel!.data!
                                                .facebookLink !=
                                            ""
                                        ? InkWell(
                                            onTap: () async {
                                              if (await canLaunch(logic
                                                  .detailsServicesModel!
                                                  .data!
                                                  .facebookLink!)) {
                                                await launch(logic
                                                    .detailsServicesModel!
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
                                              //     logic.detailsServicesModel!.data!
                                              //         .facebookLink!);
                                            },
                                            child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor:
                                                  HexaColor.fromHexa('#01AEA8'),
                                              child: SvgPicture.asset(
                                                'assets/images/Path 1221.svg',
                                                width: 20,
                                                height: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                .facebookLink !=
                                            ""
                                        ? SizedBox(
                                            width: 16.w,
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                .instagramLink !=
                                            ""
                                        ? InkWell(
                                            onTap: () async {
                                              if (await canLaunch(logic
                                                  .detailsServicesModel!
                                                  .data!
                                                  .instagramLink!)) {
                                                await launch(logic
                                                    .detailsServicesModel!
                                                    .data!
                                                    .instagramLink!);
                                              } else {
                                                Get.snackbar(
                                                    'Error', 'Can not launch');
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor: Color(0xff01AEA8),
                                              child: SvgPicture.asset(
                                                'assets/images/insta.svg',
                                                width: 20.w,
                                                height: 20.h,
                                                fit: BoxFit.fill,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                .instagramLink! !=
                                            ""
                                        ? SizedBox(
                                            width: 16.w,
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                .twitterLink !=
                                            ""
                                        ? InkWell(
                                            onTap: () async {
                                              if (await canLaunch(logic
                                                  .detailsServicesModel!
                                                  .data!
                                                  .facebookLink!)) {
                                                await launch(logic
                                                    .detailsServicesModel!
                                                    .data!
                                                    .twitterLink!);
                                              } else {
                                                Get.snackbar(
                                                    'Error', 'Can not launch');
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor:
                                                  HexaColor.fromHexa('#01AEA8'),
                                              child: SvgPicture.asset(
                                                'assets/images/twitter.svg',
                                                width: 20.w,
                                                height: 20.h,
                                                fit: BoxFit.fill,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                .twitterLink !=
                                            ""
                                        ? SizedBox(
                                            width: 16.w,
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                    .dribbleLink !=
                                                "" &&
                                            logic.detailsServicesModel!.data!
                                                    .dribbleLink !=
                                                null
                                        ? InkWell(
                                            onTap: () async {
                                              print(logic.detailsServicesModel!
                                                  .data!.dribbleLink);
                                              if (await canLaunch(logic
                                                  .detailsServicesModel!
                                                  .data!
                                                  .dribbleLink!)) {
                                                await launch(logic
                                                    .detailsServicesModel!
                                                    .data!
                                                    .dribbleLink!);
                                              } else {
                                                Get.snackbar(
                                                    'Error', 'Can not launch');
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor:
                                                  HexaColor.fromHexa('#01AEA8'),
                                              child: SvgPicture.asset(
                                                'assets/images/Group 1030.svg',
                                                width: 20.w,
                                                height: 20.h,
                                                fit: BoxFit.fill,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    logic.detailsServicesModel!.data!
                                                    .dribbleLink !=
                                                "" ||
                                            logic.detailsServicesModel!.data!
                                                    .dribbleLink !=
                                                null
                                        ? SizedBox(
                                            width: 16.w,
                                          )
                                        : Container(),
                                    InkWell(
                                      onTap: () async {
                                        String number =
                                            "${logic.detailsServicesModel!.data!.mobileNumberCountrycode}${logic.detailsServicesModel!.data!.phoneNumber}";
                                        String url =
                                            "https://wa.me/$number?text=Hello";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          Get.snackbar('Error', 'Can not launch');
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 19,
                                        backgroundColor:
                                            HexaColor.fromHexa('#01AEA8'),
                                        child: SvgPicture.asset(
                                          'assets/images/whatsapp.svg',
                                          width: 20.w,
                                          height: 20.h,
                                          fit: BoxFit.fill,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                                                    ),
                                                  ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child:logic
            .detailsServicesModel!
            .data!
            .branches!.length == 0
        ? Center(
        child: Image.asset(
        'assets/images/not-found.png',
        width: 125.w,
        height: 125.h,
        )) : Column(
                            children: [


                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (c, i) {
                                      return Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),

                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    await MapsLauncher.launchCoordinates(
                                                        double.parse(logic
                                                            .detailsServicesModel!
                                                            .data!
                                                            .branches![i].addressLatitude),
                                                        double.parse(logic
                                                            .detailsServicesModel!
                                                            .data!
                                                            .branches![i].addressLongitude));
                                                  },
                                                  child: Row(

                                                children: [
                                                  SizedBox(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    child: Image.asset(
                                                      'assets/images/locator.png',
                                                    ),
                                                  ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(top: 8.0,right: 7,left: 7),
                                                       child: Text(
                                                            logic
                                                            .detailsServicesModel!
                                                            .data!
                                                            .branches![i]
                                                            .name!
                                                          ,

                                                        style: TextStyle(
                                                            decoration: TextDecoration.underline,
                                                            fontSize: 14.sp,
                                                            color: Color(0xff054769),
                                                            fontWeight:
                                                            FontWeight.w600),
                                                                                                       ),
                                                     ),


                                                ],
                                              )),SizedBox(
                                                height: 10.h,

                                              ), Row(

                                                children: [
                                                  SizedBox(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    child: Icon(size:30,
                                                      Icons.phone_android,color: Color(0xff054769),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0,right: 7,left: 7),
                                                    child: Text(
                                                      logic
                                                          .detailsServicesModel!
                                                          .data!
                                                          .branches![i]
                                                          .country_code!+ logic
                                                          .detailsServicesModel!
                                                          .data!
                                                          .branches![i]
                                                          .phone_number!
                                                      ,

                                                      style: TextStyle(

                                                          fontSize: 14.sp,
                                                          color: Color(0xff054769),
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                  ),


                                                ],
                                              ),SizedBox(child: Divider(color: Color(
                                                  0x6f13222a).withOpacity(.2),),width: 130,)
                                            ],
                                          ),);
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
                                        .branches!.length),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              );
      }),
    );
  }
  double rating = 0;

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

}
