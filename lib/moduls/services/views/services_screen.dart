import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/services_controller.dart';
import 'my_services_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    Get.put(ServicesController());

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Services', style: TextStyle(fontSize: 20.sp)),
        actions: [
          // "My purchased services" shortcut.
          IconButton(
            tooltip: 'My Services',
            onPressed: () => Get.to(() => const MyServicesScreen()),
            icon: const Icon(Icons.redeem),
          ),
          SizedBox(width: 6.w),
        ],
      ),
      body: GetBuilder<ServicesController>(
        builder: (logic) {
          if (logic.loading) {
            return Center(child: CircularProgressIndicator(color: primary));
          }
          if (logic.services.isEmpty) {
            return RefreshIndicator(
              onRefresh: logic.fetchServices,
              child: ListView(children: [
                SizedBox(height: 200.h),
                Center(child: Text('No services available', style: TextStyle(color: Colors.grey))),
              ]),
            );
          }
          return RefreshIndicator(
            onRefresh: logic.fetchServices,
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: logic.services.length,
              itemBuilder: (context, i) {
                final s = Map<String, dynamic>.from(logic.services[i]);
                return _ServiceCard(service: s, controller: logic, primary: primary);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  final ServicesController controller;
  final Color primary;
  const _ServiceCard(
      {required this.service, required this.controller, required this.primary});

  @override
  Widget build(BuildContext context) {
    final bought = (service['bought_count'] ?? 0) as int;
    final unused = (service['unused_count'] ?? 0) as int;
    final priceBefore = service['price_before'];
    final pricePay = controller.priceOf(service);
    final busy = controller.busyId == service['id'];

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + purchased badge
          Stack(
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: (service['image'] != null && '${service['image']}'.isNotEmpty)
                    ? Image.network('${service['image']}', fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xffE9EEF3),
                            child: Icon(Icons.medical_services, size: 48, color: primary)))
                    : Container(
                        color: const Color(0xffE9EEF3),
                        child: Icon(Icons.medical_services, size: 48, color: primary)),
              ),
              if (bought > 0)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: const Color(0xff2E7D32),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text('Purchased ×$bought',
                          style: const TextStyle(color: Colors.white, fontSize: 11)),
                    ]),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${service['title'] ?? ''}',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                if ('${service['description'] ?? ''}'.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text('${service['description']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey[600])),
                ],
                SizedBox(height: 10.h),
                Row(
                  children: [
                    if (priceBefore != null && (priceBefore is num ? priceBefore : 0) > 0) ...[
                      Text('$priceBefore',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                      SizedBox(width: 8.w),
                    ],
                    Text('$pricePay BHD',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: primary)),
                    const Spacer(),
                    if (unused > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFF3E0),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text('$unused available',
                            style: const TextStyle(color: Color(0xffE65100), fontSize: 11)),
                      ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed:
                        busy ? null : () => controller.buyService(context, service),
                    child: busy
                        ? const SizedBox(
                            height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : Text(bought > 0 ? 'Buy Again' : 'Buy Service',
                            style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
