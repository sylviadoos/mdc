import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/add_card/card_controller/card_controller.dart';
import 'package:mdc_card/moduls/add_card/views/widgets/no_card.dart';

import '../widgets/card_item.dart';
import 'add_card.dart';

class CardScreen extends StatefulWidget {
  CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var controller = Get.put(CardController());
  @override
  void initState() {
    super.initState();
    controller.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 242.w,
          height: 44.h,
          child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Get.to(AddCard());
            },
            label: Text("addMedicalDiscountCard".tr,        style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                fontSize: 16.sp, color: Colors.white),),
          ),
        ),
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("requestCard".tr),
          actions: [
            InkWell(
              onTap: () {
                Get.to(AddCard());
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24.w,
                  )),
            ),
          ],
        ),
        body: GetBuilder<CardController>(builder: (logic) {
          return logic.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : logic.cardModel!.data == null
                  ? NoCard()
                  : Padding(
                    padding: const EdgeInsets.only(bottom: 17.0),
                    child: Column(
                        children: [
                          Flexible(
                            child: ListView.separated(
                                itemBuilder: (c, i) {
                                  return CardItem(
                                    dataCards: logic.cardModel!.data![i],
                                  );
                                },
                                separatorBuilder: (c, i) {
                                  return SizedBox(
                                    height: 0.h,
                                  );
                                },
                                itemCount: logic.cardModel!.data!.length),
                          ),
                          SizedBox(
                            height: 35.h,
                          )
                        ],
                      ),
                  );
        }));
  }
}
