import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/constant.dart';

class ApiDio {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: ''));

  ApiDio._internal();

  static final _singleton = ApiDio._internal();

  factory ApiDio() => _singleton;
// Base URL is switched from shared/constant.dart -> useLocalServer flag.
//   online: https://app.mdc-card.com/api
//   local:  http://10.0.2.2:8000/api (see constant.dart)
  static Dio createDio() {
    var dio = Dio(BaseOptions(
        baseUrl: activeBaseUrl,
        receiveTimeout: Duration(seconds: 15000), // 15 seconds
        connectTimeout: Duration(seconds: 15000),
        sendTimeout: Duration(seconds: 15000),
        contentType: Headers.jsonContentType,
        headers: {
          'apikey': apiKey,
          'Accept': 'application/json',
        }));

    dio.interceptors.addAll({
      // AppInterceptors(),
    });
    return dio;
  }
}
//
// class AppInterceptors extends Interceptor {
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     print('error');
//     // Assume 401 stands for token expired
//     // if (err.response?.statusCode == 401) {
//     //   print('error');
//     //   await SharePref.setData(key: 'token', data: '');
//     //   // token = await SharePref.getData(key: 'token');
//     //   await SharePref.setData(key: 'isRegister', data: false);
//     //   isRegister = false;
//     //
//     //   navigatorKey.currentState
//     //       ?.pushNamedAndRemoveUntil(RoutesName.loginScreen, (route) => false);
//     //   // var options = error.response!.requestOptions;
//     //   // // If the token has been updated, repeat directly.
//     //   // if (csrfToken != options.headers['csrfToken']) {
//     //   //   options.headers['csrfToken'] = csrfToken;
//     //   //   //repeat
//     //   //   dio.fetch(options).then(
//     //   //     (r) => handler.resolve(r),
//     //   //     onError: (e) {
//     //   //       handler.reject(e);
//     //   //     },
//     //   //   );
//     //   //   return;
//     //   // }
//     //   // tokenDio.get('v1/get/user').then((d) {
//     //   //   //update csrfToken
//     //   //   options.headers['csrfToken'] = csrfToken = d.data['data']['token'];
//     //   // }).then((e) {
//     //   //   //repeat
//     //   //   dio.fetch(options).then(
//     //   //     (r) => handler.resolve(r),
//     //   //     onError: (e) {
//     //   //       handler.reject(e);
//     //   //     },
//     //   //   );
//     //   // });
//     //   // return;
//     // }
//     await _shouldRetry(err, handler);
//
//     return handler.next(err);
//   }
// }
//
// _shouldRetry(DioError err, handler) async {
//   if (err.type == DioErrorType.other && err.error is SocketException) {
//     try {
//       handler.resolve(await scheduleRequestRetry(err.requestOptions));
//     } catch (e) {
//       // Let any new error from the retrier pass through
//       handler.next(e as DioError);
//     }
//   }
// }

// Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
//   final dio = ApiDio.createDio();
//   final connectivity = Connectivity();
//   final responseCompleter = Completer<Response>();
//   late StreamSubscription streamSubscription;
//   streamSubscription = connectivity.onConnectivityChanged.listen(
//     (connectivityResult) async {
//       print(connectivityResult);
//       if (connectivityResult != ConnectivityResult.none) {
//         streamSubscription.cancel();
//         // Complete the completer instead of returning
//         responseCompleter.complete(
//           dio.request(requestOptions.path,
//               cancelToken: requestOptions.cancelToken,
//               data: requestOptions.data,
//               onReceiveProgress: requestOptions.onReceiveProgress,
//               onSendProgress: requestOptions.onSendProgress,
//               queryParameters: requestOptions.queryParameters,
//               options: requestOptions.data),
//         );
//       } else {
//         print('Connection less Still');
//       }
//     },
//   );
//
//   return responseCompleter.future;
// }
