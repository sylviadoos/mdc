import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';

import '../../../add_card/card_controller/card_controller.dart';

class DetailsOffer extends StatefulWidget {
  bool offerTaken;
   DetailsOffer({Key? key,required this.offerTaken}) : super(key: key);

  @override
  State<DetailsOffer> createState() => _DetailsOfferState();
}

class _DetailsOfferState extends State<DetailsOffer>
    with SingleTickerProviderStateMixin {
  @override
  initState() {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 25.w,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "offer".tr,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ],
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
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          Image.network(
                            logic.detailsOffersModel!.data!.logo!,
                            // fit: BoxFit.fill,
                            width: double.infinity,
                            height: 150.h,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            logic.detailsOffersModel!.data!
                                                .name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 24,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            logic.detailsOffersModel!.data!
                                                .description!,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Color(0xff57575B),
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            logic.detailsOffersModel!.data!
                                                .priceAfterdis!
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color(0xff01AEA8)),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Text(
                                            logic.detailsOffersModel!.data!
                                                .priceBeforeDis!
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Color(0xff054769),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  'expire_date'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    " ${logic.detailsOffersModel!.data!.expireDate}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(75, 76, 77, 0.84),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text(
                                  'price'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      decoration: TextDecoration.underline,
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${'beforeDiscount'.tr} : ',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  75, 76, 77, 0.84),
                                            ),
                                          ),
                                          Text(
                                            " ${logic.detailsOffersModel!.data!.priceBeforeDis}",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${'afterDiscount'.tr} :  ',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  75, 76, 77, 0.84),
                                            ),
                                          ),
                                          Text(
                                            " ${logic.detailsOffersModel!.data!.priceAfterdis}",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${'price_afterdis_Mdc'.tr} :  ',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  75, 76, 77, 0.84),
                                            ),
                                          ),
                                          Text(
                                            " ${logic.detailsOffersModel!.data!.priceAfterdisMdc}",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                (widget. offerTaken)
                                    ? Container():  Align(
                                  alignment: Alignment.center,
                                  child: Container(padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
                                    width: Get.width,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                        ))),
                                        onPressed: () {
                                          CardController()
                                              .changePayValue('visa');
                                          logic.takeOffer(
                                              context,
                                              logic
                                                  .detailsOffersModel!.data!.id,
                                              logic.detailsOffersModel!.data!
                                                  .priceAfterdis);
                                        },
                                        child: Text(
                                          'takeOffer'.tr,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          )))
                        ],
                      ),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
