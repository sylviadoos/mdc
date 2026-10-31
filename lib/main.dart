import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/firebase_options.dart';
import 'package:mdc_card/moduls/add_card/card_controller/card_controller.dart';
import 'package:mdc_card/moduls/main/views/screens/main_screen.dart';
import 'package:mdc_card/services/api/auth_requests.dart';
import 'package:mdc_card/services/local_data/share_pref.dart';
import 'package:mdc_card/shared/binding.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:mdc_card/utils/languages/translation.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';

import 'moduls/auth/view/screen/login.dart';

void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    name: "MDCCard",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await initFirebaseMessaging();
    tokenFireBase = await FirebaseMessaging.instance
        .getToken()
        .timeout(const Duration(seconds: 10));
    debugPrint(tokenFireBase.toString());
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } catch (e) {
    // getToken() requires a real APNs token, which simulators (and
    // occasionally real devices on a slow/unreliable connection) don't
    // provide. Without this, a failure here blocks runApp() entirely,
    // leaving the app on a permanent black screen.
    debugPrint('Firebase messaging init failed: $e');
  }
  SharePref.init();
  AuthDio.init();
  await AuthDio.getApiKey();
  FlutterNativeSplash.remove();
  runApp(MyApp());
  token = await SharePref.getData(key: 'token');
  userId = await SharePref.getData(key: 'userId');
  print(token);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, s) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: Messages(),
              initialBinding: MainBinding(),
              fallbackLocale: Locale('en'),
              locale: Locale('en'),
              theme: lightTheme,
              home: SplashScreens(),
            ));
  }
}

//
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  Get.put(CardController()).getCards();
  print('Handling a background message ${message.data}');
}

initFirebaseMessaging() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Get.put(CardController()).getCards();
    //foreground
    Get.snackbar("", message.data['body'],
        colorText: Colors.white, backgroundColor: Color(0xff00416B));
    print(message.data);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    Get.put(CardController()).getCards();
    print(message.data);
  });
}

class SplashScreens extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 9),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      token == null ? LoginScreen() : MainScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/logo1.gif",
                gaplessPlayback: true, fit: BoxFit.contain)));
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

