import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mdc_card/moduls/offer/models/offers_details.dart';
import 'package:mdc_card/moduls/offer/models/offers_model.dart';
import 'package:mdc_card/services/api/main_requests.dart';

class OffersController extends GetxController {
  OffersModel? offersModel;
  DetailsOffersModel? detailsOffersModel;
  DetailsOffersModel? detailsDirctoryModel;

  bool isLoading = false;
  @override
  void onInit() {
    getOffers();
    MainDio.init();
    super.onInit();
  }

  getOffers() async {
    isLoading = true;
    update();
    offersModel = await MainDio.getOffers();
    isLoading = false;
    update();
    print(offersModel!.message);
  }

  getOffersFilter(String filter) async {
    offersModel = await MainDio.getFilterOffers(filter);
    update();
    // print(offersModel!.message);
  }
  getDirectoryFilter(String filter) async {
    offersModel = await MainDio.getFilterOffers(filter);
    update();
    // print(offersModel!.message);
  }

  getDetailsOffer(int id) async {
    isLoading = true;
    update();
    print(id);
    detailsOffersModel = await MainDio.getOffersDetails(id);
    isLoading = false;
    update();
  }

  getDetailsDirctory(int id) async {
    isLoading = true;
    update();
    detailsOffersModel = await MainDio.getDirctoryDetails(id);
    isLoading = false;
    update();
  }
}
