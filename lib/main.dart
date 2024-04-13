import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/firebase_options.dart';
import 'package:mdc_card/moduls/add_card/card_controller/card_controller.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';
import 'package:mdc_card/moduls/auth/view/screen/update_app_version.dart';
import 'package:mdc_card/moduls/main/views/screens/main_screen.dart';
import 'package:mdc_card/services/api/auth_requests.dart';
import 'package:mdc_card/services/local_data/share_pref.dart';
import 'package:mdc_card/shared/binding.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:mdc_card/utils/languages/translation.dart';
import 'package:mdc_card/utils/themes/light_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'moduls/auth/view/screen/login.dart';
import 'moduls/main/controller/main_controller.dart';

void main() async {
  // ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    name: "MDCCard",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initFirebaseMessaging();
  tokenFireBase = await FirebaseMessaging.instance.getToken();
  debugPrint(tokenFireBase.toString());
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SharePref.init();
  AuthDio.init();
  await AuthDio.getApiKey();
  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
  token = await SharePref.getData(key: 'token');
  userId = await SharePref.getData(key: 'userId');
  lang = await SharePref.getData(key: 'lang')??'en';
  print(token);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, s) => GetMaterialApp(
              // theme: Theme.of(context).copyWith(
              //   appBarTheme: Theme.of(context)
              //       .appBarTheme
              //       .copyWith(backgroundColor: Theme.of(context).primaryColor,),
              // ),
              debugShowCheckedModeBanner: false,
              translations: Messages(),
              initialBinding: MainBinding(),

              fallbackLocale: Locale(lang!),
              locale: Locale(lang!),
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
 // var authController = Get.put(AuthController());
  var logic = Get.put(MainController());

  bool showCountry = false;
  @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 9),
        () => setState(() {
          showCountry = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Image.asset("assets/images/logo1.gif",
                    gaplessPlayback: false, fit: BoxFit.contain),
                Visibility(visible: showCountry,
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(StatefulBuilder(
                        builder: (context, state) {
                          return Container(
                            height: 600.h,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    // padding: EdgeInsets.zero,
                                      title: Text("selectArea".tr),
                                      trailing: IconButton(
                                        icon: CircleAvatar(
                                          radius: 10,
                                          backgroundColor:
                                          Theme.of(context)
                                              .primaryColor,
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 20.w,
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      )),
                                  Flexible(
                                    child: ListView.separated(
                                        itemBuilder: (c, i) {
                                          return ListTile(
                                            onTap: () {
                                              logic.changeSelectCountry(
                                                  logic
                                                      .countryModel
                                                      [i]
                                                      .name!,
                                                  logic
                                                      .countryModel[i]
                                                      .id!);
                                              Get.back();
                                            },
                                            // padding: EdgeInsets.zero,
                                            title: Text(logic
                                                .countryModel[i]
                                                .name!),
                                          );
                                        },
                                        separatorBuilder: (c, i) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              DottedBorder(
                                                color: HexaColor
                                                    .fromHexa(
                                                    '#E8E8E8'),
                                                dashPattern: const [
                                                  8,
                                                  4
                                                ],
                                                strokeWidth: .5,
                                                customPath: (size) {
                                                  return Path()
                                                    ..moveTo(0, 0)
                                                    ..lineTo(
                                                        size.width,
                                                        0);
                                                },
                                                child: Container(),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                            ],
                                          );
                                        },
                                        itemCount: logic.countryModel
                                            .length),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ), isScrollControlled: true);

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      height: 44.h,
                      width: Get.width * .50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: HexaColor.fromHexa('#F8F8F8'),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            logic.country!.length > 12
                                ? logic.country!.substring(0, 12) +
                                '...'
                                : logic.country!,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 20.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
