import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:mdc_card/moduls/profile/controller/profile_controller.dart';

import '../moduls/add_card/card_controller/card_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainController());
    Get.put(OffersController());
    Get.put(AuthController());
    Get.put(ProfileController());
    Get.put(CardController());
  }
}
