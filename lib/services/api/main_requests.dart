import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdc_card/moduls/add_card/models/card_type_model.dart';
import 'package:mdc_card/moduls/add_card/models/document_model.dart';
import 'package:mdc_card/moduls/main/models/city_model.dart';
import 'package:mdc_card/moduls/main/models/home_model.dart';
import 'package:mdc_card/moduls/offer/models/offers_details.dart';
import 'package:mdc_card/moduls/offer/models/offers_model.dart';
import 'package:mdc_card/shared/constant.dart';

import '../../moduls/add_card/models/card_model.dart';
import '../../moduls/add_card/models/information_single.dart';
import '../../moduls/profile/models/notification_model.dart';
import 'dio.dart';

class MainDio {
  static Dio? dio;
  static String? baseUrl;
  static init() {
    dio = ApiDio.createDio();
    baseUrl = dio!.options.baseUrl;
  }

  static Future<HomeModel?> getHome() async {
    String url = '$baseUrl/home';
    Response request;
    HomeModel? homeModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        homeModel = HomeModel.fromJson(request.data);
        print(homeModel);
      } else {}
    } on Exception catch (e) {
      print(e);
    }
    return homeModel;
  }

  static Future<CityModel?> getCity() async {
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
      } else {
        cityModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return cityModel;
  }

  static Future<OffersModel?> getOffers() async {
    String url = '$baseUrl/offers/listing';
    Response request;
    OffersModel? offersModel;
    try {
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

  static Future<OffersModel?> search(String n) async {
    String url = '${baseUrl}/offers/listing?search=$n';
    Response request;
    OffersModel? offersModel;
    try {
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            'userId': userId,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));
 print(request.data);
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

  static Future<OffersModel?> getFilterOffers(String filterText) async {
    String url = '$baseUrl/offers/search';
    Response request;
    OffersModel? offersModel;
    try {
      request = await dio!.post(url,
          data: {'city_name': filterText},
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
  static Future<OffersModel?> getFilterDirectory(String filterText) async {
    String url = '$baseUrl/directory/search';
    Response request;
    OffersModel? offersModel;
    try {
      request = await dio!.post(url,
          data: {'city_name': filterText},
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

  static Future<DetailsOffersModel?> getOffersDetails(int id) async {
    String url = '$baseUrl/offer/detail';
    Response request;
    DetailsOffersModel? detailsOffersModel;
    try {
      request = await dio!.post(url,
          data: {"hospital_id": id},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        detailsOffersModel = DetailsOffersModel.fromJson(request.data);
      } else {
        detailsOffersModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return detailsOffersModel;
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

  static Future<DetailsOffersModel?> getDirctoryDetails(int id) async {
    String url = '$baseUrl/directory/detail';
    Response request;
    print(id);
    DetailsOffersModel? detailsOffersModel;
    try {
      request = await dio!.post(url,
          data: {"hospital_id": id},
          options: Options(headers: {
            'apikey': apiKey,
            'device_token': tokenFireBase,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
          }));

      if (request.statusCode! < 400) {
        detailsOffersModel = DetailsOffersModel.fromJson(request.data);
      } else {
        detailsOffersModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return detailsOffersModel;
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
    String? countryCode

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
        "country_code": countryCode,
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
    List<XFile?>? image,
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
    String? allMember,
    String? allGccid,
    String? countryCode

  }) async {
    String url = '$baseUrl/family/card2';
    Response request;
    InformationCardSingle? informationCardSingle;

    try {
      Map<String, dynamic> formDataMap = {
        "fullname": fullname,
        "type": "family",
        "country_code": countryCode,
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
        "all_member_gcc_id": allGccid,

      };
      for (int i = 0; i < image!.length; i++) {


    formDataMap['document_upload_$i'] = await MultipartFile.fromFile(image[i]!.path, filename: image[i]!.name);
      }
      FormData data = FormData.fromMap(formDataMap);

      request = await dio!.post(url,
          data: data,
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
