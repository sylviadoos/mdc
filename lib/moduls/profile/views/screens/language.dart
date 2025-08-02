// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mdc_card/services/local_data/share_pref.dart';
import 'package:mdc_card/shared/constant.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 22,
        ),
        title: Text("language".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isArabic = true;
                  Get.updateLocale(Locale('ar'));
                });
                await SharePref.setData(key: 'ar', data: "ar");
                lang = await SharePref.getData(key: 'lang');
              },
              child: Row(
                children: [
                  Text(
                    'العربية',
                    style: !isArabic
                        ? Theme.of(context).textTheme.displayMedium
                        : Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: const Color(0xff009196)),
                  ),
                  const Spacer(),
                  if (isArabic)
                    const Icon(
                      Icons.check,
                      size: 22,
                      color: Color(0xff009196),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            const Divider(),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isArabic = false;
                  Get.updateLocale(Locale('en'));
                });
                await SharePref.setData(key: 'en', data: "en");
                lang = await SharePref.getData(key: 'lang');
              },
              child: Row(
                children: [
                  Text(
                    'English',
                    style: isArabic
                        ? Theme.of(context).textTheme.displayMedium
                        : Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: const Color(0xff009196),
                            ),
                  ),
                  const Spacer(),
                  if (!isArabic)
                    const Icon(
                      Icons.check,
                      size: 22,
                      color: Color(0xff009196),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
