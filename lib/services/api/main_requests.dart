import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdc_card/moduls/add_card/models/card_type_model.dart';
import 'package:mdc_card/moduls/add_card/models/document_model.dart';
import 'package:mdc_card/moduls/main/models/city_model.dart';
import 'package:mdc_card/moduls/main/models/home_model.dart';
import 'package:mdc_card/moduls/offer/models/offer_payment.dart';
import 'package:mdc_card/moduls/offer/models/offers_details.dart';
import 'package:mdc_card/moduls/offer/models/services_details.dart';
import 'package:mdc_card/moduls/offer/models/services_model.dart';
import 'package:mdc_card/moduls/offer/models/take_offer.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../moduls/add_card/models/card_model.dart';
import '../../moduls/add_card/models/information_single.dart';
import '../../moduls/offer/models/get_all_user_offers.dart';
import '../../moduls/offer/models/offers_model.dart';
import '../../moduls/offer/models/qr_offers_model.dart';
import '../../moduls/offer/models/take_rate_qr_offer.dart';
import '../../moduls/profile/models/notification_model.dart';
import 'dio.dart';
import 'package:mdc_card/moduls/main/models/CountryModel.dart';
import 'dart:developer' as dev;
class MainDio {
  static Dio? dio;
  static String? baseUrl;

  static init() {
    dio = ApiDio.createDio();
    baseUrl = dio!.options.baseUrl;
  }

  static Future<HomeModel?> getHome(String country) async {
    log('$baseUrl/home');
    String url = '$baseUrl/home?city=$country';
    Response request;
    HomeModel? homeModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
print({
  'apikey': apiKey,
  'device_token': tokenFireBase,
  'devicetype': Platform.isAndroid ? "Android" : "ios",
}.toString());
      if (request.statusCode! < 400) {
        homeModel = HomeModel.fromJson(request.data);
        print(homeModel);
      } else {}
    } on Exception catch (e) {
      print(e);
    }
    return homeModel;
  }
  static Future<CountryModel?> getCountries() async {
    log('$baseUrl/cities');
    log('$apiKey apiKey');
    String url = '$baseUrl/countries';
    Response request;
    CountryModel? countryModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        countryModel = CountryModel.fromJson(request.data);
        print('cityModel${request.data}');

      } else {
        countryModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
   // print('cityModel${countryModel.data!.cityList![1].name}');
    return countryModel;
  }

  static Future<CityModel?> getCity() async {
    log('$baseUrl/cities');
    log('$apiKey apiKey');
    String url = '$baseUrl/cities';
    Response request;
    CityModel? cityModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        cityModel = CityModel.fromJson(request.data);
        print('cityModel1${request.data.toString()}');
        print('cityModel${cityModel!.data!.cityList![1].name}');
      } else {
        cityModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return cityModel;
  }

  static Future<ServicesModel?> getServices(String country) async {
    String url =country=='Select country'? '$baseUrl/offers/listing':'$baseUrl/offers/listing?city=$country';
    Response request;
    ServicesModel? servicesModel;
    try {
      log(url);
      log('''
      {     'apikeyhhh': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        print('request.data');

        print(request.data);
        servicesModel = ServicesModel.fromJson(request.data);
      } else {
        servicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return servicesModel;
  }

  static Future<OffersModel?> getOffers() async {
    String url = '$baseUrl/allNewoffer';
    Response request;
    OffersModel? offersModel;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        offersModel = OffersModel.fromJson(request.data);
      } else {
        offersModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return offersModel;
  }

  static Future<AllUserOffers?> getAllUserOffers() async {
    String url = '$baseUrl/getallUseroffers';
    Response request;
    AllUserOffers? allUserOffers;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'userId': $userId,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'userId': userId,
          }));

      if (request.statusCode! < 400) {
        allUserOffers = AllUserOffers.fromJson(request.data);
      } else {
        allUserOffers = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return allUserOffers;
  }

  static Future<TakeOfferModel?> getTakeOffer(offerId) async {
    String url = '$baseUrl/getNewoffer';
    Response request;
    TakeOfferModel? takeOfferModel;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'device_token': $tokenFireBase,
             'userId': $userId,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      request = await dio!.post(url,
          data: {"offer_id": offerId},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'userId': userId,
          }));
      print('request.data${request.data}');
      if (request.statusCode! < 400) {
        takeOfferModel = TakeOfferModel.fromJson(request.data);
      } else {
        takeOfferModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return takeOfferModel;
  }
  static Future<TakeOfferModel?> useOfferInHospital(offerId) async {
    String url = '$baseUrl/getoffer';
    Response request;
    TakeOfferModel? useOfferModel;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'device_token': $tokenFireBase,
             'userId': $userId,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      log('''{"offer_id": $offerId}''');
      request = await dio!.post(url,
          data: {"offer_id": offerId},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'userId': userId,
          }));
      print('request.data${request.data}');
      if (request.statusCode! < 400) {
        useOfferModel = TakeOfferModel.fromJson(request.data);
      } else {
        useOfferModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return useOfferModel;
  }

  static Future<OfferPaymentModel?> offerPayment(price) async {
    String url = '$baseUrl/addOfferPayment';
    Response request;
    OfferPaymentModel? offerPaymentModel;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
            'userId': $userId
          }''');
      request = await dio!.post(url,
          data: {"type_pay": "visa", "price": price},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'userId': userId,
          }));
      print('request.data${request.data}');
      if (request.statusCode! < 400) {
        offerPaymentModel = OfferPaymentModel.fromJson(request.data);
      } else {
        offerPaymentModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return offerPaymentModel;
  }

  static Future<ServicesModel?> search(String n,String country) async {
    String url = '${baseUrl}/offers/listing?search=$n&city=$country';
    Response request;
    ServicesModel? servicesModel;
    try {
      log(url);
      log('''
      {     'apikey': $apiKey,
            'userId': $userId,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'userId': userId,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
      print(request.data);
      print(request.statusCode);
      if (request.statusCode! < 400) {
        servicesModel = ServicesModel.fromJson(request.data);
      } else {
        servicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }

    return servicesModel;
  }

  static Future<ServicesModel?> getFilterOffers(String filterText,String country) async {
    String url = '$baseUrl/offers/search';
    log(url);
    log({'city_name': filterText,'country':country}.toString());
    Response request;
    ServicesModel? servicesModel;
    try {
      log(url);
      request = await dio!.post(url,
          data: {'city_name': filterText,'country':country},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        servicesModel = ServicesModel.fromJson(request.data);
      } else {
        servicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return servicesModel;
  }

  static Future<ServicesModel?> getFilterDirectory(String filterText) async {
    String url = '$baseUrl/directory/search';
    Response request;
    ServicesModel? servicesModel;
    try {
      request = await dio!.post(url,
          data: {'city_name': filterText},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        servicesModel = ServicesModel.fromJson(request.data);
      } else {
        servicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return servicesModel;
  }

  static Future<DetailsServicesModel?> getServicesDetails(int id) async {
    String url = '$baseUrl/offer/detail';
    Response request;
    DetailsServicesModel? detailsServicesModel;
    try {
      print(url);
      print(''' {
            'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');
      print('''{"hospital_id": $id}''');
      request = await dio!.post(url,
          data: {"hospital_id": id},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        detailsServicesModel = DetailsServicesModel.fromJson(request.data);
        print('detailsOffersModel1');
        dev.log(request.data.toString());

      } else {
        detailsServicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return detailsServicesModel;
  }

  static Future<OffersDetailsModel?> getOffersDetails(int id) async {
    String url = '$baseUrl/newoffer/detail';
    Response request;
    OffersDetailsModel? offersDetailsModel;
    try {
      print(url);
      print(''' {
            'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');

      request = await dio!.post(url,
          data: {"offer_id": id},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        offersDetailsModel = OffersDetailsModel.fromJson(request.data);
        print('detailsOffersModel${offersDetailsModel.data}');
      } else {
        offersDetailsModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return offersDetailsModel;
  }

  static Future<NotificationModel?> getNotifations() async {
    String url = '$baseUrl/notification/listing';
    Response request;
    NotificationModel? detailsOffersModel;
    try {
      request = await dio!.post(url,
          options: Options(headers: {
            'apikey': apiKey,
            'userid': userId,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        detailsOffersModel = NotificationModel.fromJson(request.data);
      } else {
        detailsOffersModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return detailsOffersModel;
  }

  static Future<DetailsServicesModel?> getDirctoryDetails(int id) async {
    String url = '$baseUrl/directory/detail';
    Response request;
    print(id);
    DetailsServicesModel? detailsServicesModel;
    try {
      print(url);
      print('{"hospital_id": $id}');
      print('''{
            'apikey': $apiKey,
            'device_token': $tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }''');
      request = await dio!.post(url,
          data: {"hospital_id": id},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        detailsServicesModel = DetailsServicesModel.fromJson(request.data);
      } else {
        detailsServicesModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return detailsServicesModel;
  }

  static getOffersQRCode(qrText) async {
    String url = '$baseUrl/readQr';
    Response request;
    QrOffersModel? offersModel;
    try {
      print(url);
      print(' {"qr_text": $qrText}');
      request =
          await dio!.post(url, data: {"qr_text": qrText}, options: Options());
      if (request.statusCode! < 400) {
        offersModel = QrOffersModel.fromJson(request.data);
      } else {
        offersModel = null;
      }
    } on Exception catch (e) {
      print('ExceptionException$e');
    }
    return offersModel;
  }

  static postSelectedServiceQRCodeAndRate(
      serviceId, hospitalId, userRate) async {
    String url = '$baseUrl/readQrDetails';
    Response request;
    TakeAndRateQrOfferModel? takeAndRateQrOfferModel;
    try {
      print(url);
      print('''  {
          "service_id": $serviceId,
          "hospital_id": $hospitalId,
          "rate": $userRate
          }''');
      request = await dio!.post(url,
          data: {
            "service_id": serviceId,
            "hospital_id": hospitalId,
            "rate": userRate
          },
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'userid': userId,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
      if (request.statusCode! < 400) {
        takeAndRateQrOfferModel =
            TakeAndRateQrOfferModel.fromJson(request.data);
      } else {
        takeAndRateQrOfferModel = null;
      }
    } on Exception catch (e) {
      print('ExceptionException$e');
    }
    return takeAndRateQrOfferModel;
  }

  static Future<InformationCardSingle?> postSingleCard({
    XFile? image,
    String? fullname,
    String? mobileNumber,
    String? gccId,
    String? city,
    String? country,
    int? cardType,
    int? documentType,
    String? gender,
    String? price,
    String? payType,
    String? typePay,
  }) async {
    String url = '$baseUrl/single/card2';
    Response request;
    InformationCardSingle? informationCardSingle;
    print(userId);
    try {
      FormData formData = FormData.fromMap({
        "document_upload":
            await MultipartFile.fromFile(image!.path, filename: image.name),
        "fullname": fullname,
        "type": "family",
        "country_code": "973",
        "mobile_number": mobileNumber,
        "gcc_id": gccId,
        "city": city,
        "country": country,
        "card_type": cardType,
        "document_type": documentType,
        "gender": gender,
        "price": price,
        "type_pay": payType,
      });

      print(url);
      print(formData.fields);
      print('''{
            'apikey': $apiKey,
            'userid': $userId,
            'device_token': $tokenFireBase,
            'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          }''');

      request = await dio!.post(url,
          data: formData,
          options: Options(headers: {
            'apikey': apiKey,
            'userid': userId,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        informationCardSingle = InformationCardSingle.fromJson(request.data);
      } else {
        informationCardSingle = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return informationCardSingle;
  }

  static Future<String?> postContact(
      {String? name, String? email, String? massage, String? type}) async {
    String url = '$baseUrl/getin/touch';
    Response request;
    String? massege;
    print(email);
    try {
      FormData formData = FormData.fromMap(
          {"name": name, "email": email, "type": type, "message": massage});
      request = await dio!.post(url,
          data: formData,
          options: Options(headers: {
            'apikey': apiKey,
            'userid': userId,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
      print(request.data);
      if (request.statusCode! < 400) {
        massege = request.data['message'];
      } else {
        massege = request.data['message'];
      }
    } on Exception catch (e) {
      print(e);
    }
    return massege;
  }

  //
  static Future<InformationCardSingle?> postfamilyCard({
    XFile? image,
    String? fullname,
    String? mobileNumber,
    String? gccId,
    String? city,
    String? country,
    int? cardType,
    int? documentType,
    String? gender,
    String? price,
    String? payType,
    String? allMember
  }) async {
    String url = '$baseUrl/family/card2';
    Response request;
    InformationCardSingle? informationCardSingle;

    try {
      FormData formData = FormData.fromMap({
        "document_upload":
            await MultipartFile.fromFile(image!.path, filename: image.name),
        "fullname": fullname,
        "type": "family",
        "country_code": "973",
        "mobile_number": mobileNumber,
        "gcc_id": gccId,
        "city": city,
        "country": country,
        "card_type": cardType,
        "document_type": documentType,
        "gender": gender,
        "price": price,
        "type_pay": payType,
        "all_member_name": allMember,

      });
      log(url);
      log(formData.fields.toString());
      log('''{
        'apikey': $apiKey,
        'userid': $userId,
        'device_token': $tokenFireBase,
        'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
      }''');
      request = await dio!.post(url,
          data: formData,
          options: Options(headers: {
            'apikey': apiKey,
            'userid': userId,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
      print(request.data);
      if (request.statusCode! < 400) {
        informationCardSingle = InformationCardSingle.fromJson(request.data);
      } else {
        informationCardSingle = null;
      }
    } on Exception catch (e) {
      print(e);
      throw Exception;
    }
    return informationCardSingle;
  }

  static Future<CardTypeModel?> getCardType() async {
    String url = '$baseUrl/card/type';
    Response request;
    CardTypeModel? cardTypeModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        cardTypeModel = CardTypeModel.fromJson(request.data);
      } else {
        cardTypeModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return cardTypeModel;
  }

  static Future<DocumentTypeModel?> getDocumentType() async {
    String url = '$baseUrl/document/type';
    Response request;
    DocumentTypeModel? documentTypeModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        documentTypeModel = DocumentTypeModel.fromJson(request.data);
      } else {
        documentTypeModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return documentTypeModel;
  }

  static Future<CardModel?> getCards() async {
    String url = '$baseUrl/card/History';
    Response request;
    CardModel? cardModel;
    try {
      log('$baseUrl/card/History');
      log(''''{
          'apikey': $apiKey,
          'device_token': $tokenFireBase,
          'devicetype': ${Platform.isAndroid ? "Android" : "ios"},
          "userid": $userId,
          }''');
      request = await dio!.post(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            "userid": userId,
          }));
      print(userId);
      print(request);

      print(request);
      if (request.statusCode! < 400) {
        cardModel = CardModel.fromJson(request.data);
      } else {
        cardModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return cardModel;
  }
}
