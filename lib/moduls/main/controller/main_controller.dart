import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/main/models/city_model.dart';
import 'package:mdc_card/moduls/main/models/home_model.dart';
import 'package:mdc_card/moduls/main/views/screens/home_screen.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/services/api/main_requests.dart';
import 'package:mdc_card/moduls/main/models/CountryModel.dart';
import 'package:mdc_card/moduls/main/models/CountryModel.dart' as dataModel;

import '../../../shared/constant.dart';
import '../../add_card/views/screens/card.dart';
import '../../auth/view/screen/login.dart';
import '../../offer/models/services_model.dart';
import '../../offer/views/screens/offers_screen.dart';
import '../../offer/views/screens/services_screen.dart';
import '../../profile/views/screens/profile_screen.dart';
import '../views/screens/main_screen.dart';

class MainController extends GetxController {
  HomeModel? homeModel;
  CityModel? cityModel;
  List<dataModel.CityList> countryModel =[dataModel.CityList(id: '+973',name: 'Bahrain'),dataModel.CityList(id: '+90',name: 'Turkey')]  ;
  String? country='Select country';
  String? country_id='0';

  int selectedIndex = 0;
  TextEditingController search = TextEditingController();
  List<String?> textFilter = [];
  ServicesModel? servicesModel;
  List<DataOffer> searchList = [];
  String? filterText='';
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
    servicesModel = await MainDio.getServices(country!);
    searchList = servicesModel!.data!;
    print(searchList.length);
    update();
  }

  serach(String s) async {
    searchList.clear();
     isLoading = true;
     update();
    servicesModel=await MainDio.search(s,country!);
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
    // ServicesScreen(),
    MyProfile(),
  ];
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
    if (selectedIndex == 2) {
      Get.put(OffersController()).getServices();
    }
    update();
  }

  getHome() async {
    isLoadingHome = true;
    homeModel = await MainDio.getHome(country!);
    isLoadingHome = false;
    // print(homeModel!.status);
    update();
  }

  getCity() async {
    cityModel = await MainDio.getCity();
    // print(cityModel!.status);
  }
  changeSelectCountry(String s,String id) async {
    country = s;
    country_id = id;
   // update();

    Get.offAll(token == null
        ? LoginScreen()
        : MainScreen());
    isLoadingHome=true;

    getOffers();
    getHome();
    // getCity();
  //  await MainDio.getServices(country!);

    update();
      // builder: (context) => (authController.versionModel!.updated!)
      //     ? token == null
      //         ? LoginScreen()
      //         : MainScreen()
      //     : UpdateAppVersion()),




  }
  // getCountries() async {
  //   countryModel = await MainDio.getCountries();
  //   // print(cityModel!.status);
  // }
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
      //getCountries();
    });
    super.onInit();
  }
}
