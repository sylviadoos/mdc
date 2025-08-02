import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../utils/themes/light_theme.dart';
import '../../../offer/controllers/offer_controller.dart';
import '../../../offer/views/screens/services_screen.dart';
import '../../controller/main_controller.dart';

class MoreFilters extends StatelessWidget {
  const MoreFilters({
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
                              Get.to(ServicesScreen());
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
