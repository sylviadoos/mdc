import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdc_card/moduls/auth/models/user_model.dart';
import 'package:mdc_card/moduls/profile/models/profile_model.dart';
import 'package:mdc_card/services/local_data/share_pref.dart';

import '../../shared/constant.dart';
import 'dio.dart';

class AuthDio {
  static Dio? dio;
  static String? baseUrl;
  static init() {
    dio = ApiDio.createDio();
    baseUrl = dio!.options.baseUrl;
  }

  static Future<String?> getApiKey() async {
    String url = '$baseUrl/getApiKey';
    Response request;
    String? apiKey;
    try {
      request = await dio!.get(url,
          options: Options(
              headers: {'xapikey': "veletqdkopqdxu-mdc-cwrekymtguztizzsk"}));
      if (request.statusCode! < 400) {
        apiKey = request.data['data']['apikey'];
        SharePref.init();
        SharePref.setData(key: "apiKey", data: apiKey);
        apiKey = await SharePref.getData(key: "apiKey");
        print(apiKey);
      } else {
        apiKey = "";
      }
    } on Exception catch (e) {
      print(e);
    }
    return apiKey;
  }

  static Future<UserModel?> signUp({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
  }) async {
    String url = '$baseUrl/signup';
    Response request;
    UserModel? userModel;
    try {
      request = await dio!.post(url,
          data: {
            "login_type": "Manual",
            "fullname": fullName!,
            "email": email,
            "phone_number": phoneNumber,
            "password": password,
            "password_confirmation": password,
            "device_token": tokenFireBase,
          },
          options: Options(headers: {
            'apiKey': apiKey,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'device_token': tokenFireBase,
            'userrole': "user",
          }));
      print(request);
      if (request.data['status'] == 1) {
        userModel = UserModel.fromJson(request.data);
        await SharePref.init();
        await SharePref.setData(
            key: "token", data: userModel.data!.user!.accessToken!);
        await SharePref.setData(key: "userId", data: userModel.data!.user!.id!);
      } else {
        userModel = UserModel.fromJson(request.data);
      }
    } on Exception catch (e) {
      print(e);
    }
    return userModel;
  }
  static Future<String?> forget(
    String? email,
  ) async {
    String url = '$baseUrl/forget/password';
    Response request;
    String? userModel;
    try {
      request = await dio!.post(url,
          data: {
            "email": email,
          },
          options: Options(headers: {
            'apiKey': apiKey,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'userrole': "user",
          }));
      if (request.statusCode! < 400) {
        userModel=request.data['message'];
      } else {
        userModel=request.data['message'];
      }
    } on Exception catch (e) {
      print(e);
    }
    return userModel;
  }

  static Future<UserModel?> login({
    String? email,
    String? password,
  }) async {
    print(password);
    String url = '$baseUrl/login';
    Response request;
    UserModel? userModel;
    try {
      request = await dio!.post(url,
          data: {
            "login_type": "Manual",
            "email": email,
            "password": password,
            "device_token": tokenFireBase,
          },
          options: Options(headers: {
            'apiKey': apiKey,
            'devicetype': Platform.isAndroid ? "Android" : "ios",
            'device_token': tokenFireBase,
            'userrole': "user",
          }));
      print(request.data);
      if (request.data['status'] == 1) {
        userModel = UserModel.fromJson(request.data);
        await SharePref.init();
        await SharePref.setData(
            key: "token", data: userModel.data!.user!.accessToken!);
        await SharePref.setData(key: "userId", data: userModel.data!.user!.id!);
      } else {
        userModel = UserModel.fromJson(request.data);
      }
    } on Exception catch (e) {
      print(e);
    }
    return userModel;
  }

  static Future<ProfileModel?> editProfile({
    String? email,
    String? password,
    String? address,
    String? city,
    String? country,
    String? gender,
    XFile? image,
    String? name,
    String? phone,
    String? brithday,
  }) async {
    String url = '$baseUrl/update/profile';
    Response request;
    ProfileModel? profileModel;
    try {
      print(brithday);
      FormData formData = FormData.fromMap({
        'fullname': name,
        'profile_image':
        await MultipartFile.fromFile(image!.path, filename: image.name),
        "login_type": "Manual",
        "email": email,
        "phone_number": phone,
        "device_token": tokenFireBase,
        "country_code": "+973",
        "address": address,
        "address2": "a",
        "city": city,
        "country": country.toString(),
        "gender": gender,
        "birth_date": brithday,
      });
      request = await dio!.post(url,
          data: formData,
          options: Options(headers: {
            'apiKey': apiKey,
            'userId': userId,
            "accesstoken": token
          }));
      print(request);
      if (request.statusCode! < 400) {
        profileModel = ProfileModel.fromJson(request.data);
      } else {
        profileModel = ProfileModel.fromJson(request.data);
      }
    } on Exception catch (e) {
      print(e);
    }
    return profileModel;
  }

  static Future<UserModel?> loginSocial({
    String? social_id,
    String? type,
    String? email,
  }) async {
    print(social_id);
    String url = '$baseUrl/social/login';
    Response request;
    UserModel? userModel;
    try {
      request = await dio!.post(url,
          data: {
            "login_type": type,
            "device_token": tokenFireBase,
            "social_id": social_id
          },
          options: Options(
              headers: {
                'apiKey': apiKey,
                'devicetype': Platform.isAndroid ? "Android" : "ios",
                'device_token': tokenFireBase,
                'userrole': "user",
              }));
      print(request);
      if (request.data['status'] == 1) {
        userModel = UserModel.fromJson(request.data);
        await SharePref.init();
        await SharePref.setData(
            key: "token", data: userModel.data!.user!.accessToken!);
        await SharePref.setData(key: "userId", data: userModel.data!.user!.id!);
      } else if (request.data['status'] ==0) {
        url = '$baseUrl/signup';
        print(social_id);
        request = await dio!.post(url,
            data: {
              "login_type": type,
              "device_token": tokenFireBase,
              "social_id": social_id,
              "email": email,
            },
            options: Options(headers: {
              'apiKey': apiKey,
              'devicetype': Platform.isAndroid ? "Android" : "ios",
              'device_token': tokenFireBase,
              'userrole': "user",
            }));
        print(social_id);

        print("Ahned${request.data}");
        if (request.data['status'] == 1) {
          userModel = UserModel.fromJson(request.data);
          await SharePref.init();
          await SharePref.setData(
              key: "token", data: userModel.data!.user!.accessToken!);
          await SharePref.setData(
              key: "userId", data: userModel.data!.user!.id!);
        } else {
          userModel = null;
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return userModel;
  }

  static Future<ProfileModel?> getProfile() async {
    String url = '$baseUrl/get/profile';
    Response request;
    ProfileModel? profileModel;
    try {
      print(userId);
      request = await dio!.get(url,
          options: Options(headers: {
            'apikey': apiKey,
            "userid": userId,
            "accesstoken": token
          }));
      if (request.statusCode! < 400) {
        profileModel = ProfileModel.fromJson(request.data);
        print(token);
      } else {
        profileModel = null;
      }
    } on Exception catch (e) {
      print(e);
    }
    return profileModel;
  }

  static Future<String?> getTerm() async {
    String url = '$baseUrl/terms/services';
    Response request;
    String? value;
    try {
      print(userId);
      request = await dio!.get(
        url,
      );
      if (request.statusCode! < 400) {
        value = jsonEncode(request.data);
        print(value);
      }
    } on Exception catch (e) {
      print(e);
    }
    return value;
  }

  static Future<String?> logout() async {
    String url = '$baseUrl/logout';
    Response request;
    String? apiKey;
    try {
      request = await dio!.post(url,
          options: Options(headers: {
            'apikey': apiKey,
            "userid": userId,
            "accesstoken": token
          }));
      if (request.statusCode! < 400) {
        apiKey = request.data['message'];
        SharePref.init();
      } else {
        apiKey = "";
      }
    } on Exception catch (e) {
      print(e);
    }
    return apiKey;
  }
}
