import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mdc_card/moduls/add_card/models/card_model.dart';

import '../../../../shared/constant.dart';
import '../../../../utils/themes/light_theme.dart';

class CardItem extends StatelessWidget {
  DataCards? dataCards;

  CardItem({
    required this.dataCards,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(11.0),
      child:  FlipCard(

        flipOnTouch: true,
        direction: FlipDirection.HORIZONTAL,
        front: Container(
          height: MediaQuery.sizeOf(context).width * .56,
          width: MediaQuery.sizeOf(context).width * .9,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xff00416B), offset: Offset(1, 1), blurRadius: 7)
              ],
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                fit: BoxFit.fill,
                image:lang == "en" ? AssetImage("assets/images/cardar.png"):AssetImage("assets/images/cardar.png"),
              )),
          child: Directionality(
            textDirection: lang == "en" ? TextDirection.ltr:TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Column(
        
                children: [
                  Expanded(flex: 3, child: Container()),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
    Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                lang == "en" ? "Membership number : " : "رقم العضوية : ",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white),
    ))),
    Container(
    padding: EdgeInsets.all(2),
    width: 120.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          dataCards!.policy!,
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                                                        ))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
    Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          lang == "en" ? "Full Name : " : "اسم المستفيد : ",
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    ))),
    Container(
    padding: EdgeInsets.all(2),
    width: 120.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          dataCards!.fullname!,
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    ))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
    Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          lang == "en" ? "GccId : " : "رقم الإثبات : ",
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    ))),
    Container(
    padding: EdgeInsets.all(2),
    width: 120.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          dataCards!.gccId!,
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    )) ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
    Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          lang == "en" ? "Expired Date : " : "تاريخ الانتهاء : ",
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                                                        ))),
    Container(
    padding: EdgeInsets.all(2),
    width: 120.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                                          dataCards!.expiredDate!,
                                                          style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    ))),
                            ],
                          ),
                        ),

                          SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
    Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                lang == "en" ? "Card type : " : "نوع البطاقة : ",
                                style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                              ))),
    Container(
    padding: EdgeInsets.all(2),
    width: 120.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                                lang == "en" ? dataCards!.type.toString() :dataCards!.type=='family'?'عائلى':'فردى',
                                style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
    ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), back: Container(
        height: 195.h,
        width: 300.w,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xff00416B), offset: Offset(1, 1), blurRadius: 7)
            ],
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              fit: BoxFit.fill,
              image:lang == "en" ? AssetImage("assets/images/carden.png"):AssetImage("assets/images/cardar.png"),
            )),
        child: Directionality(
          textDirection: lang == "en" ? TextDirection.ltr:TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(flex: 3, child: Container()),
                Expanded(
                  flex: 8,
                  child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child:   Container(
    padding: EdgeInsets.all(2),
    width: 100.w,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: HexaColor.fromHexa('#0B646B')),
    child: Center(
    child:Text(
                            lang == "en" ? "Family member names : " : "اسماء أفراد العائلة : ",
                            style:
                            TextStyle(fontSize: 12.sp, color:Colors.white),
    )))),

                      dataCards!.all_member_name!.toString() !='' ?Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.w),
              child:   Text(
                            dataCards!.all_member_name!.toString().replaceAll(",", "\n"),
                            style:
                            TextStyle(fontSize: 12.sp, color:  HexaColor.fromHexa('#0B646B')),
    )):Container(),

                      SizedBox(
                        height: 4.h,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    ));
  }
}
