import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../add_card/card_controller/card_controller.dart';
import '../../add_card/views/screens/web_view.dart';
import '../api/services_requests.dart';

class ServicesController extends GetxController {
  List<dynamic> services = [];
  List<dynamic> myServices = [];
  bool loading = false;
  bool myLoading = false;
  dynamic busyId; // service currently being bought/used

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    loading = true;
    update();
    services = await ServicesDio.getServices();
    loading = false;
    update();
  }

  Future<void> fetchMyServices() async {
    myLoading = true;
    update();
    myServices = await ServicesDio.getMyServices();
    myLoading = false;
    update();
  }

  /// The price the customer pays (prefers the MDC discounted price).
  num priceOf(Map service) {
    final mdc = service['price_after_mdc'];
    final after = service['price_after'];
    if (mdc != null && (mdc is num ? mdc : num.tryParse('$mdc') ?? 0) > 0) {
      return mdc is num ? mdc : num.tryParse('$mdc') ?? 0;
    }
    return after is num ? after : num.tryParse('$after') ?? 0;
  }

  /// Buy a service: create payment -> open payment webview -> record purchase.
  Future<void> buyService(BuildContext context, Map service) async {
    final price = priceOf(service);
    if (price <= 0) {
      Get.snackbar('', 'Invalid service price',
          backgroundColor: const Color(0xff00416B), colorText: Colors.white);
      return;
    }
    busyId = service['id'];
    update();

    final pay = await ServicesDio.payForService(price: price);
    final result = pay['result'];
    final url = (result is Map) ? result['url'] : null;

    if (pay['status'] == 1 && url != null) {
      final card = Get.put(CardController());
      card.redirect = null;
      await Get.to(() => WebViewCheck(url));

      if (card.redirect == 'success') {
        await ServicesDio.recordPurchase(service['id']);
        Get.snackbar('', 'Service purchased successfully',
            backgroundColor: const Color(0xff00416B), colorText: Colors.white);
        await fetchServices();
      } else {
        Get.snackbar('', 'Payment was not completed',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } else {
      Get.snackbar('', pay['message']?.toString() ?? 'Could not start payment',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    busyId = null;
    update();
  }

  /// Mark one unused purchase of a service as used.
  Future<void> useService(dynamic offerId) async {
    busyId = offerId;
    update();
    final res = await ServicesDio.useService(offerId);
    busyId = null;
    if (res['status'] == 1) {
      Get.snackbar('', res['message']?.toString() ?? 'Marked as used',
          backgroundColor: const Color(0xff00416B), colorText: Colors.white);
      await fetchMyServices();
      await fetchServices();
    } else {
      Get.snackbar('', res['message']?.toString() ?? 'Could not use service',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    update();
  }
}
