import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/offer/views/screens/details_services.dart';
import 'package:mdc_card/utils/component/component.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import '../../offer/controllers/offer_controller.dart';
import '../../offer/views/screens/details_offers.dart';
import '../controller/main_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0.h,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),
      ),
      body: GetBuilder<MainController>(
          builder: (logic) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.w,
                          ),
                        ),
                        Text(
                          'searchTitle'.tr,
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                        SvgPicture.asset(
                          'assets/images/Layer 1.svg',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )),
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultFormField(
                      controller: logic.search,
                      onChange: (s) {
                      },
                      onSubmit: (s){
                        logic.serach(s!);
                  },
                      prefix: Icon(
                        Icons.search,
                        size: 30.w,
                        color: Colors.black,
                      ),
                      hintText: "search".tr,writeTextColor: Colors.black,
                      hintStyle:
                          TextStyle(fontSize: 18.sp, color: Colors.black),
                      fillColor: HexaColor.fromHexa('#F1F4F6'),
                      type: TextInputType.text,
                      borderColor: Colors.transparent),
                ),
              ),
              logic.isLoading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                    )
                  :  logic.servicesModel!.data == null || logic.servicesModel!.data!.length==0
                  ?  Expanded(
            child: Center(
                child: Image.asset(
                  'assets/images/not-found.png',
                  width: 125.w,
                  height: 125.h,
                ),
              ))
                  : Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (c, i) {
                              return InkWell(
                                  onTap: () async {
                                    Get.to(DetailsServices());
                                    var controller =
                                        Get.put(OffersController());
                                    print(logic.servicesModel!.data![i].id);
                                    await controller.getDetailsServices(
                                        logic.servicesModel!.data![i].id!);
                                    // await controller.getDetailsDirctory(
                                    //     logic.servicesModel!.data![i].id!);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 16.0.h, bottom: 8.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            logic.servicesModel!.data![i].logo!,
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
                                                    logic.servicesModel!.data![i].name!,
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Text(
                                                  logic.servicesModel!.data![i].description!  .trim(),

                                                  style: TextStyle(
                                                      color: HexaColor.fromHexa(
                                                          '#707070'),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                              ;
                            },
                            itemCount: logic.servicesModel!.data!.length),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
