import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/main/models/city_model.dart';
import 'package:mdc_card/moduls/main/models/home_model.dart';
import 'package:mdc_card/moduls/main/views/screens/home_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/services/api/main_requests.dart';

import '../../add_card/views/screens/card.dart';
import '../../offer/models/offers_model.dart';
import '../../offer/views/screens/offers_screen.dart';
import '../../profile/views/screens/profile_screen.dart';

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
    MyProfile(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
    if (selectedIndex == 2) {
      Get.put(OffersController()).getOffers();
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
