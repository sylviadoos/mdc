import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/services_controller.dart';

/// The customer's purchased-but-unused services, with a "Use Now" action.
class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final controller = Get.put(ServicesController());
    // Load fresh when opening.
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.fetchMyServices());

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('My Services', style: TextStyle(fontSize: 20.sp)),
      ),
      body: GetBuilder<ServicesController>(
        builder: (logic) {
          if (logic.myLoading) {
            return Center(child: CircularProgressIndicator(color: primary));
          }
          if (logic.myServices.isEmpty) {
            return RefreshIndicator(
              onRefresh: logic.fetchMyServices,
              child: ListView(children: [
                SizedBox(height: 180.h),
                Icon(Icons.redeem, size: 60, color: Colors.grey[400]),
                SizedBox(height: 12.h),
                Center(
                    child: Text('You have no unused services yet',
                        style: TextStyle(color: Colors.grey))),
              ]),
            );
          }
          return RefreshIndicator(
            onRefresh: logic.fetchMyServices,
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: logic.myServices.length,
              itemBuilder: (context, i) {
                final s = Map<String, dynamic>.from(logic.myServices[i]);
                final unused = (s['unused_count'] ?? 0) as int;
                final busy = logic.busyId == s['offer_id'];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 64.w,
                          height: 64.w,
                          child: (s['image'] != null && '${s['image']}'.isNotEmpty)
                              ? Image.network('${s['image']}', fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xffE9EEF3),
                                      child: Icon(Icons.medical_services, color: primary)))
                              : Container(
                                  color: const Color(0xffE9EEF3),
                                  child: Icon(Icons.medical_services, color: primary)),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${s['title'] ?? ''}',
                                style: TextStyle(
                                    fontSize: 15.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4.h),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFF3E0),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('$unused available',
                                  style: const TextStyle(
                                      color: Color(0xffE65100), fontSize: 11)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        height: 40.h,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2E7D32),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: busy
                              ? null
                              : () => _confirmUse(context, logic, s),
                          icon: busy
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.check, color: Colors.white, size: 18),
                          label: const Text('Use Now',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _confirmUse(
      BuildContext context, ServicesController logic, Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Use Service'),
        content: Text('Use one "${s['title']}" now? This will reduce your available count.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              logic.useService(s['offer_id']);
            },
            child: const Text('Use Now'),
          ),
        ],
      ),
    );
  }
}
