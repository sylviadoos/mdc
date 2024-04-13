import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdc_card/moduls/add_card/models/card_model.dart';
import 'package:mdc_card/moduls/add_card/models/card_type_model.dart';
import 'package:mdc_card/moduls/add_card/models/document_model.dart';
import 'package:mdc_card/moduls/add_card/views/screens/card.dart';
import 'package:mdc_card/moduls/add_card/views/screens/web_view.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/main/views/screens/main_screen.dart';
import 'package:mdc_card/moduls/offer/models/offer_payment.dart';
import 'package:mdc_card/moduls/offer/models/take_offer.dart';
import 'package:mdc_card/services/api/main_requests.dart';
import 'package:mdc_card/shared/accept_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/constant.dart';
import '../models/information_single.dart';

class CardController extends GetxController {
  String groupValue = "familyCard";
  String groupSex = "male";
  String countryCode = '+973';
  String valueArea = "selectArea".tr;
  String? city;
  String? valueDoc;
  String? nationality;
  String? cardType;
  XFile? _image;
  String? groupPay = "visa";
  List? friendsList = [''];

  TakeOfferModel? takeOfferModel;

  XFile? get image => _image;
  String groupValuePay = 'yes';
  CardTypeModel? cardTypeModel;
  DocumentTypeModel? documentTypeModel;
  String? price;
  int? idCard;
  int? idDoc;
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController gcc_id = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isApproved = false;
  CardModel? cardModel;
  bool isLoading = false;
  InformationCardSingle? informationCardSingle;
  String? TypeApi = "visa";
  String? redirect;

  changeApproved() {
    isApproved = !isApproved;
    update();
  }

  makeSingleCard(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (city == null) {
        Get.snackbar("sorry".tr, "selectArea".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (nationality == null) {
        Get.snackbar("sorry".tr, "selectNationality".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (cardType == null) {
        Get.snackbar("sorry".tr, "selectTypeCard".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (valueDoc == null) {
        Get.snackbar("sorry".tr, "choseTypeDoc".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else {
        informationCardSingle = await MainDio.postSingleCard(
            image: image,
            fullname: name.text,
            mobileNumber: phone.text,
            gccId: gcc_id.text,
            city: city,
            country: nationality,
            gender: groupSex,
            cardType: idCard,
            documentType: idDoc,
            payType: TypeApi,
            price: price);
        // print(
        //     'informationCardSingle!.message${informationCardSingle!.message}');
        // print('informationCardSingle!.status${informationCardSingle!.status}');
        // print(
        //     'informationCardSingle!.result!.url${informationCardSingle!.result!.url}');
        print(informationCardSingle!.status);
        if (informationCardSingle!.status == 1) {
          if (informationCardSingle!.result!.url != null) {
            print(informationCardSingle!.result!.url);
            Get.to(WebViewCheck(informationCardSingle!.result!.url));
            if (redirect == 'failed') {
              Get.back();
              Get.bottomSheet(AcceptRequest(
                  img: 'assets/images/error.png', title: 'failed'.tr));
            } else if (redirect == 'success') {
              Get.bottomSheet(AcceptRequest(
                img: 'assets/images/img_21.png',
                title: 'requestAccept'.tr,
              ));
              groupValue = "familyCard";
              groupSex = "male";
              valueArea = "selectArea".tr;
              nationality = null;
              gcc_id.clear();
              _image = null;
              valueDoc = null;
              cardType = null;
              city = null;
              name.clear();
              phone.clear();
              Get.put(MainController()).selectedIndex = 1;
              Get.offAll(MainScreen());
              getCards();
            } else if (redirect == 'failed') {
              Get.bottomSheet(AcceptRequest(
                  img: 'assets/images/error.png', title: 'failed'.tr));
            }
            // Get.snackbar("success".tr, informationCardSingle!.message!,
            //     backgroundColor: Color(0xff00416B), colorText: Colors.white);
            // groupValue = "familyCard";
            // groupSex = "male";
            // valueArea = "selectArea".tr;
            // nationality = null;
            // gcc_id.clear();
            // _image = null;
            // valueDoc = null;
            // cardType = null;
            // city = null;
            // name.clear();
            // phone.clear();
            // Get.off(MainScreen());
            // update();
          } else if (informationCardSingle!.result!.url == null) {
            Get.bottomSheet(AcceptRequest(
              img: 'assets/images/img_21.png',
              title: 'requestAccept'.tr,
            ));
            Get.put(MainController()).selectedIndex = 1;
            Get.offAll(MainScreen());
            getCards();
            groupValue = "familyCard";
            groupSex = "male";
            valueArea = "selectArea".tr;
            nationality = null;
            gcc_id.clear();
            _image = null;
            valueDoc = null;
            cardType = null;
            city = null;
            name.clear();
            phone.clear();
            update();
            String url = "https://wa.me/+97366903009/?text=hello";
            await launchUrl(Uri.parse(url));
          }
        } else {
          print(informationCardSingle);
          Get.snackbar("Sorry", informationCardSingle!.message!,
              backgroundColor: Color(0xff00416B), colorText: Colors.white);
        }
      }
    }
  }

//
  makefamily(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (city == null) {
        Get.snackbar("sorry".tr, "selectArea".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (nationality == null) {
        Get.snackbar("sorry".tr, "selectNationality".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (cardType == null) {
        Get.snackbar("sorry".tr, "selectTypeCard".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (valueDoc == null) {
        Get.snackbar("sorry".tr, "choseTypeDoc".tr,
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else if (image == null) {
        Get.snackbar("sorry".tr,
            lang == "ar" ? "Please upload Image" : "يرجئ تحميل صورة",
            backgroundColor: Theme.of(context).primaryColor,
            colorText: Colors.white);
      } else {
        Get.bottomSheet(Container(
          height: 275.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white),
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ));
        informationCardSingle = await MainDio.postfamilyCard(
            image: image,
            fullname: name.text,
            mobileNumber: phone.text,
            gccId: gcc_id.text,
            city: city,
            country: nationality,
            gender: groupSex,
            cardType: idCard,
            documentType: idDoc,
            payType: TypeApi,
            price: price,
        allMember:friendsList!.join(','));
        Get.back();
        print(informationCardSingle!.message);
        print(informationCardSingle!.status);
        print('informationCardSingle!.result${informationCardSingle!.result}');
        print(
            'informationCardSingle!.result!.url${informationCardSingle!.result!.url}');
        if (informationCardSingle!.status == 1) {
          if (informationCardSingle!.result!.url != null) {
            print(informationCardSingle!.result!.url);
            Get.to(WebViewCheck(informationCardSingle!.result!.url));
            if (redirect == 'failed') {
              Get.back();
              Get.bottomSheet(AcceptRequest(
                  img: 'assets/images/error.png', title: 'failed'.tr));
            } else if (redirect == 'success') {
              Get.bottomSheet(AcceptRequest(
                img: 'assets/images/img_21.png',
                title: 'requestAccept'.tr,
              ));
              groupValue = "familyCard";
              groupSex = "male";
              valueArea = "selectArea".tr;
              nationality = null;
              gcc_id.clear();
              _image = null;
              valueDoc = null;
              cardType = null;
              city = null;
              name.clear();
              phone.clear();
              Get.put(MainController()).selectedIndex = 1;
              Get.to(MainScreen());
              getCards();
            } else if (redirect == 'failed') {
              Get.bottomSheet(AcceptRequest(
                  img: 'assets/images/error.png', title: 'failed'.tr));
            }
            // Get.snackbar("success".tr, informationCardSingle!.message!,
            //     backgroundColor: Color(0xff00416B), colorText: Colors.white);
            // groupValue = "familyCard";
            // groupSex = "male";
            // valueArea = "selectArea".tr;
            // nationality = null;
            // gcc_id.clear();
            // _image = null;
            // valueDoc = null;
            // cardType = null;
            // city = null;
            // name.clear();
            // phone.clear();
            // Get.off(MainScreen());
            // update();
          } else if (informationCardSingle!.result!.url == null) {
            Get.bottomSheet(AcceptRequest(
              img: 'assets/images/img_21.png',
              title: 'requestAccept'.tr,
            ));
            Get.put(MainController()).selectedIndex = 1;
            Get.to(MainScreen());
            getCards();
            groupValue = "familyCard";
            groupSex = "male";
            valueArea = "selectArea".tr;
            nationality = null;
            gcc_id.clear();
            _image = null;
            valueDoc = null;
            cardType = null;
            city = null;
            name.clear();
            phone.clear();
            update();
          }
        } else {
          print(informationCardSingle);
          Get.snackbar("Sorry", informationCardSingle!.message!,
              backgroundColor: Color(0xff00416B), colorText: Colors.white);
        }
      }
    }
  }



  changePrice(String? x) {
    price = x;
    update();
  }

  Future<void> showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      size: 20.w,
                    ),
                    title: Text(
                      'PhotoLibrary'.tr,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    onTap: () async {
                      await _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    size: 20.w,
                  ),
                  title: Text(
                    'Camera'.tr,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    await _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 350,
        maxWidth: 550);

    _image = image;
    if (_image != null) {}
    update();
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 350,
        maxWidth: 550);

    _image = image;

    update();
  }

  changeValue(String value) {
    groupValue = value;
    update();
  }

  changePayValue(String value) {
    print(value);
    groupPay = value;
    if (groupPay == "visa") {
      TypeApi = "visa";
    } else if (groupPay == "Benefit Pay") {
      TypeApi = "beniftpay";
    } else if (groupPay == "Other") {
      TypeApi = "other";
    }
    update();
  }

  changeNationality(String s) {
    nationality = s;
    update();
  }

  changeSelectTypeCard(String s) {
    cardType = s;
    update();
  }

  changePay(String s) {
    groupValuePay = s;
    update();
  }

  onChangeArea(String s) {
    valueArea = s;
    city = valueArea;
    print(city);
    update();
  }

  onChangeDoc(String s) {
    valueDoc = s;
    update();
  }

  List<String> listArea = [
    'Riffa'.tr,
    "Muharraq".tr,
    "Hamad Town".tr,
    "A'ali".tr,
    "Isa Town".tr,
    "Sitra".tr,
    "Budaiya".tr,
    "Jidhafs".tr,
    "Al-Malikiyah".tr
  ];
  List<String> listCard = [
    "Fatal Diseases",
    "Special Needs",
    "Normal Card",
    "Shukri Offer",
  ];
  List<String> listDoc = [
    "Medical Report",
    "Social Insurance Card",
    "CPR",
    "MDC Card",
  ];

  getCardType() async {
    cardTypeModel = await MainDio.getCardType();
    debugPrint(cardTypeModel!.message);
    update();
  }

  getDocumnts() async {
    documentTypeModel = await MainDio.getDocumentType();
    update();
  }

  changSex(String value) {
    groupSex = value;
    update();
  }

  changCountryCode(String value) {
    countryCode = value;
    update();
  }

  getCards() async {
    isLoading = true;
    var result = await MainDio.getCards();
    if (result != null) {
      cardModel = result;
      isLoading = false;
      update();
    } else {
      isLoading = false;
    }
    update();
  }

  @override
  void onInit() {
    getDocumnts();
    getCardType();
    MainDio.init();
    price = "19.90";
  }
}
