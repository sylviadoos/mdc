// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/profile/controller/profile_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var controller = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getNoitifactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("notification".tr),
      ),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return logic.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      logic.notificationModel!.data==null?Container():   ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, i) => buildContainerNotification(
                            context: context,
                            time: logic.notificationModel!.data![i].message!,
                            title: logic.notificationModel!.data![i].title!,
                            color: const Color(0xff009196).withOpacity(.1)),
                        itemCount: logic.notificationModel!.data!.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 16.h,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Container buildContainerNotification(
      {required BuildContext context,
      Color? color,
      required String title,
      required String time}) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              children: const [
                Icon(
                  Icons.notifications_active,
                  size: 24,
                  color: Color(0xff009196),
                )
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
