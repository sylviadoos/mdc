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

import '../../../main/controller/main_controller.dart';

class ServicesScreen extends StatefulWidget {
  ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  var controller = Get.put(OffersController());

  @override
  void initState() {
    if(Get.find<MainController>().filterText != ''){

      controller.getServices();}

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
                  "services".tr,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      FilterOffer(),
                      isScrollControlled: true,
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/images/Path 1087.svg',
                    color: Color(0xff054769),
                  )),
            ),
          ),
          Expanded(
            child: GetBuilder<OffersController>(builder: (logic) {
              return logic.isLoading
                  ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
                  : logic.servicesModel!.data == null
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
                      return GestureDetector(
                          onTap: () async {
                            Get.to(() => DetailsServices());
                            await logic.getDetailsServices(
                                logic.servicesModel!.data![i].id!);
                          },
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
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
                                      logic.servicesModel!.data![i]
                                          .logo!,
                                      fit: BoxFit.fill,
                                      width: 90.w,
                                      height: 90.h,
                                    ),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            logic.servicesModel!
                                                .data![i].name!,
                                            style: TextStyle(
                                                color: Color(
                                                    0xff054769)),
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                          ),
                                          Text(
                                            logic.servicesModel!
                                                .data![i].description!
                                                .trim(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    5, 71, 105, 0.65),
                                                // color: HexaColor
                                                //     .fromHexa(
                                                //         '#707070'),
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
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
                    itemCount: logic.servicesModel!.data!.length),
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
                                childAspectRatio: 2,
                                crossAxisCount: 2,
                                // number of items in each row
                                mainAxisSpacing: 0.0,
                                // spacing between rows
                                crossAxisSpacing: 10.0,
                                // spacing between columns
                              ),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return
                                  Container(
                                      height: 100.0,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Stack(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                logic.changeCheck(
                                                  index,
                                                  logic.cityModel!.data!.cityList![index]
                                                      .name!,
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(top: 0.0),
                                                height: MediaQuery.of(context).size.width*0.15,
                                                width: MediaQuery.of(context).size.width*0.4,
                                                child: Container(
                                                  child:  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 35.0,right: 10),
                                                      child: Text(
                                                        logic.cityModel!.data!.cityList![index]
                                                            .name!,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 10),
                                                      ),
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color(0xba000000), offset: Offset(.3, .3), blurRadius: 1)
                                                    ],
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: logic.checked[index]
                                                            ? HexaColor.fromHexa('#00A19B')
                                                            : Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0)),
                                                  ),

                                                ),
                                              ),
                                            )
                                            ,
                                            Positioned(
                                              left: 1.0,
                                              bottom: 7.0,

                                              child:
                                              Container(

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0)),
                                                  color: Colors.white,

                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color(0xba000000), offset: Offset(.3, .3), blurRadius: 2)
                                                  ],),
                                                child: Image.asset(
                                                  filterImages[index],
                                                  width: 40,
                                                  height: 40,

                                                ),
                                              ),

                                            )
                                          ],
                                        ),
                                      ));
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
