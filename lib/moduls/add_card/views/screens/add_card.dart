import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/option_card.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("requestCard".tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Image.asset(
              "assets/images/NoPath - Copy (2).png",
            )),
            SizedBox(
              height: 26.h,
            ),
            Center(
              child: Text(
                Get.locale.toString() == "en"
                    ? "What is MDC Card ?"
                    : 'ما هي بطاقة الخصم الطبي ؟',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Center(
              child: Text(
                Get.locale.toString() == "en"
                    ? "It is a service card that providers its holders\nwith a direct discount of up to 80% on \n heath, medical therapeutic, surgical,cosmetics and recreational services \nwithout exception At over 150 accredited \n  entities in Bahrain and Turkey with an \n annual issuance fee of 19.9 BHD only "
                    : "هي بطاقة خدمة تقدم لحامليها خصماً مباشراً يصل إلى %80 على الخدمات الصحية والطبية العلاجية والجراحية والتجميلية  والترفيهية دون استثناء لدى أكثر من 150 جهة معتمدة في البحرين وتركيا برسم إصدار سنوي قدرة 19.9 دينار بحريني فقط",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.grey[800]),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Text(
                Get.locale.toString() == "en"
                    ? "The First and Only card in Bahrain that offers \n a life long gift for people with special needs,\n serious illness ,and people of \n determines"
                    : "البطاقة الأولى و الوحيدة في البحرين التي تقدم هدية مدى الحياة لذوي الاحتياجات الخاصة والأمراض الخطيرة وأصحاب الهمم",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.grey[800]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: SizedBox(
              height: 44.h,
              width: 242.w,
              child: ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(OptionCard());
                },
                child: Text("orderNow".tr,        style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(
                    fontSize: 16.sp, color: Colors.white),),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
