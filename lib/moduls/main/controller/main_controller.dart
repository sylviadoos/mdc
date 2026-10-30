import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mdc_card/moduls/main/models/city_model.dart';
import 'package:mdc_card/moduls/main/models/home_model.dart';
import 'package:mdc_card/moduls/main/views/screens/home_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/services/api/main_requests.dart';

import '../../add_card/views/screens/card.dart';
import '../../offer/models/offers_model.dart';
import '../../offer/views/screens/offers_screen.dart';
import '../../profile/views/screens/profile_screen.dart';
import '../../services/api/services_requests.dart';
import '../../services/controller/services_controller.dart';
import '../../services/views/services_screen.dart';

class MainController extends GetxController {
  HomeModel? homeModel;
  CityModel? cityModel;
  int selectedIndex = 0;
  TextEditingController search = TextEditingController();
  List<String?> textFilter = [];
  OffersModel? offersModel;
  List<DataOffer> searchList = [];
  String? filterText;
  bool isLoading = false;
  bool isLoadingHome = false;
  List<bool> checked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  getOffers() async {
    offersModel = await MainDio.getOffers();
    searchList = offersModel!.data!;
    print(searchList.length);
    update();
  }

  serach(String s) async {
    searchList.clear();
     isLoading = true;
     update();
   offersModel=await MainDio.search(s);
    isLoading = false;
    update();
  }

//change
  changeCheck(int i, [String? text]) {
    //   print(text);
    checked[i] = !checked[i];
    if (checked[i]) {
      textFilter.addIf(checked[i], text);
      filterText = textFilter.join(",");
      print(filterText);
      print(textFilter);
    }
    if (!checked[i]) {
      textFilter.remove(text);
      filterText = textFilter.join(",");
    }
    update();
  }

  List<Widget> screen = [
    HomeScreen(),
    CardScreen(),
    OfferScreen(),
    const ServicesScreen(),
    MyProfile(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
    if (selectedIndex == 2) {
      Get.put(OffersController()).getOffers();
    }
    if (selectedIndex == 3) {
      Get.put(ServicesController()).fetchServices();
    }
    update();
  }

  getHome() async {
    isLoadingHome = true;
    homeModel = await MainDio.getHome();
    isLoadingHome = false;
    print(homeModel!.status);
    update();
  }

  // Unified app settings (features / popup / version) — checked once per launch.
  bool settingsChecked = false;
  bool heartRateEnabled = true;

  Future<void> loadAppSettings(BuildContext context) async {
    if (settingsChecked) return;
    settingsChecked = true;

    final s = await ServicesDio.getAppSettings();
    if (s['status'] != 1) return;

    heartRateEnabled = (s['heart_rate_enabled'] == 1);
    update();

    // 1) Force-update check (blocks the app if outdated).
    if (context.mounted) await _checkForceUpdate(context, s);

    // 2) Home popup ad.
    final popupEnabled = (s['popup_enabled'] == 1);
    final image = s['popup_image'];
    if (popupEnabled && image != null && '$image'.isNotEmpty && context.mounted) {
      _showPopup(context, '$image');
    }
  }

  Future<void> _checkForceUpdate(BuildContext context, Map s) async {
    if (s['force_update'] != 1) return;
    final required = Platform.isAndroid ? s['android_version'] : s['ios_version'];
    if (required == null || '$required'.isEmpty) return;

    final info = await PackageInfo.fromPlatform();
    if (!_isOutdated(info.version, '$required')) return;

    final url = Platform.isAndroid ? s['android_url'] : s['ios_url'];
    final msg = (s['update_message'] != null && '${s['update_message']}'.isNotEmpty)
        ? '${s['update_message']}'
        : 'A new version is available. Please update to continue.';
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('Update Required'),
          content: Text(msg),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (url != null && '$url'.isNotEmpty) {
                  await launchUrl(Uri.parse('$url'),
                      mode: LaunchMode.externalApplication);
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isOutdated(String current, String required) {
    List<int> parse(String v) => v
        .split('.')
        .map((e) => int.tryParse(e.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0)
        .toList();
    final c = parse(current), r = parse(required);
    for (int i = 0; i < r.length; i++) {
      final cv = i < c.length ? c[i] : 0;
      if (cv < r[i]) return true;
      if (cv > r[i]) return false;
    }
    return false;
  }

  void _showPopup(BuildContext context, String image) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const ServicesScreen());
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(image, fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink()),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getCity() async {
    cityModel = await MainDio.getCity();
    print(cityModel!.status);
  }

  @override
  void onInit() {
    MainDio.init();
    Future.delayed(
        Duration(
          seconds: 6,
        ), () {
      getOffers();
      getHome();
      getCity();
    });
    super.onInit();
  }
}
