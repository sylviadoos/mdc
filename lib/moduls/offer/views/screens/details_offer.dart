import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

  /// Small pill action button used inside a branch card.
  Widget _branchAction(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: color.withOpacity(.1),
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ]),
      ),
    );
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: new ColorFilter.mode(
                                          Colors.black.withOpacity(.05),
                                          BlendMode.color),
                                      image: NetworkImage(logic
                                          .detailsOffersModel!
                                          .data!
                                          .sliderImages![index]
                                          .image!),
                                    ),
                                  ),
                                ),
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
                          Tab(text: 'branches'.tr),

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

                              // ---- Branches section ----
                              if ((logic.detailsOffersModel!.data!.branches ?? [])
                                  .isNotEmpty) ...[
                                SizedBox(height: 20.h),
                                Row(children: [
                                  Icon(Icons.account_tree_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 20.w),
                                  SizedBox(width: 6.w),
                                  Text('Branches',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor)),
                                ]),
                                SizedBox(height: 12.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: logic
                                      .detailsOffersModel!.data!.branches!.length,
                                  itemBuilder: (context, i) {
                                    final b = logic
                                        .detailsOffersModel!.data!.branches![i];
                                    final primary =
                                        Theme.of(context).primaryColor;
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 12.h),
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: const Color(0xffEDEFF2)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(.04),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3)),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SizedBox(
                                              width: 56.w,
                                              height: 56.w,
                                              child: (b.logo != null &&
                                                      b.logo!.isNotEmpty)
                                                  ? Image.network(b.logo!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (_, __,
                                                              ___) =>
                                                          Container(
                                                              color: const Color(
                                                                  0xffE9EEF3),
                                                              child: Icon(
                                                                  Icons
                                                                      .local_hospital,
                                                                  color:
                                                                      primary)))
                                                  : Container(
                                                      color: const Color(
                                                          0xffE9EEF3),
                                                      child: Icon(
                                                          Icons.local_hospital,
                                                          color: primary)),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(b.name ?? '',
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                if ((b.nameAr ?? '').isNotEmpty)
                                                  Text(b.nameAr!,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.grey)),
                                                SizedBox(height: 4.h),
                                                if ((b.address ?? '').isNotEmpty)
                                                  Row(children: [
                                                    Icon(Icons.location_on,
                                                        size: 14.w,
                                                        color: Colors.redAccent),
                                                    SizedBox(width: 4.w),
                                                    Expanded(
                                                      child: Text(b.address!,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Colors
                                                                  .grey[700])),
                                                    ),
                                                  ]),
                                                SizedBox(height: 8.h),
                                                Row(children: [
                                                  if ((b.phone_number ?? '')
                                                      .isNotEmpty)
                                                    _branchAction(
                                                      icon: Icons.call,
                                                      label: 'Call',
                                                      color: primary,
                                                      onTap: () => launchUrl(
                                                          Uri.parse(
                                                              'tel:${b.country_code ?? ''}${b.phone_number}')),
                                                    ),
                                                  SizedBox(width: 8.w),
                                                  if (b.addressLatitude != null &&
                                                      '${b.addressLatitude}'
                                                          .isNotEmpty)
                                                    _branchAction(
                                                      icon: Icons.directions,
                                                      label: 'Directions',
                                                      color: const Color(
                                                          0xff2E7D32),
                                                      onTap: () => MapsLauncher
                                                          .launchCoordinates(
                                                        double.tryParse(
                                                                '${b.addressLatitude}') ??
                                                            0,
                                                        double.tryParse(
                                                                '${b.addressLongitude}') ??
                                                            0,
                                                        b.name,
                                                      ),
                                                    ),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
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
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child:logic
                                  .detailsOffersModel!
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
                                                              .detailsOffersModel!
                                                              .data!
                                                              .branches![i].addressLatitude),
                                                          double.parse(logic
                                                              .detailsOffersModel!
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
                                                                .detailsOffersModel!
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
                                                            .detailsOffersModel!
                                                            .data!
                                                            .branches![i]
                                                            .country_code!+ logic
                                                            .detailsOffersModel!
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
                                        itemCount: logic.detailsOffersModel!.data!
                                            .branches!.length),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
