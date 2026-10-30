import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mdc_card/shared/constant.dart';

import '../../../services/api/dio.dart';

/// API calls for the Purchase Services feature.
class ServicesDio {
  static Dio get _dio => ApiDio.createDio();
  static String get _base => _dio.options.baseUrl;

  static Options _opts() => Options(headers: {
        'apikey': apiKey,
        'apiKey': apiKey,
        'devicetype': Platform.isAndroid ? "Android" : "ios",
        'userrole': "user",
        'userid': userId,
      });

  /// GET /app/settings -> unified app settings (features, popup, version).
  static Future<Map<String, dynamic>> getAppSettings() async {
    try {
      final res = await _dio.get('$_base/app/settings', options: _opts());
      if (res.statusCode! < 400 && res.data is Map) {
        return Map<String, dynamic>.from(res.data);
      }
    } catch (e) {
      print('getAppSettings error: $e');
    }
    return {'status': 0};
  }

  /// GET /promo/popup -> home popup ad config {enabled, image}.
  static Future<Map<String, dynamic>> getPromoPopup() async {
    try {
      final res = await _dio.get('$_base/promo/popup', options: _opts());
      if (res.statusCode! < 400 && res.data is Map) {
        return Map<String, dynamic>.from(res.data);
      }
    } catch (e) {
      print('getPromoPopup error: $e');
    }
    return {'status': 0, 'enabled': 0};
  }

  /// GET /services/list -> list of services with per-user purchase info.
  static Future<List<dynamic>> getServices() async {
    try {
      final res = await _dio.get('$_base/services/list', options: _opts());
      if (res.statusCode! < 400 && res.data['status'] == 1) {
        return List<dynamic>.from(res.data['data'] ?? []);
      }
    } catch (e) {
      print('getServices error: $e');
    }
    return [];
  }

  /// GET /my/services -> the user's UNUSED purchased services.
  static Future<List<dynamic>> getMyServices() async {
    try {
      final res = await _dio.get('$_base/my/services', options: _opts());
      if (res.statusCode! < 400 && res.data['status'] == 1) {
        return List<dynamic>.from(res.data['data'] ?? []);
      }
    } catch (e) {
      print('getMyServices error: $e');
    }
    return [];
  }

  /// POST /service/use -> mark one unused purchase as used.
  static Future<Map<String, dynamic>> useService(dynamic offerId) async {
    try {
      final res = await _dio.post('$_base/service/use',
          data: {'offer_id': offerId}, options: _opts());
      return Map<String, dynamic>.from(res.data);
    } catch (e) {
      if (e is DioException && e.response?.data is Map) {
        return Map<String, dynamic>.from(e.response!.data);
      }
      return {'status': 0, 'message': 'Network error'};
    }
  }

  /// POST /addOfferPayment -> creates the payment order, returns payment URL.
  static Future<Map<String, dynamic>> payForService(
      {required num price, String typePay = 'visa'}) async {
    try {
      final res = await _dio.post('$_base/addOfferPayment',
          data: {'price': price, 'type_pay': typePay}, options: _opts());
      return Map<String, dynamic>.from(res.data);
    } catch (e) {
      if (e is DioException && e.response?.data is Map) {
        return Map<String, dynamic>.from(e.response!.data);
      }
      return {'status': 0, 'message': 'Network error'};
    }
  }

  /// POST /getNewoffer -> record the purchase in user_offers (after payment).
  static Future<Map<String, dynamic>> recordPurchase(dynamic offerId) async {
    try {
      final res = await _dio.post('$_base/getNewoffer',
          data: {'offer_id': offerId}, options: _opts());
      return Map<String, dynamic>.from(res.data);
    } catch (e) {
      if (e is DioException && e.response?.data is Map) {
        return Map<String, dynamic>.from(e.response!.data);
      }
      return {'status': 0, 'message': 'Network error'};
    }
  }
}
