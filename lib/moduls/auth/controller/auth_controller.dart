import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mdc_card/moduls/auth/models/user_model.dart';
import 'package:mdc_card/moduls/main/views/screens/main_screen.dart';
import 'package:mdc_card/shared/constant.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../services/api/auth_requests.dart';
import '../../../services/local_data/share_pref.dart';

class AuthController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController emailForget = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetLoginKey = GlobalKey<FormState>();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController emailLogin = TextEditingController();
  String? redirect;
  UserModel? userModel;
  bool isPassword = false;
  bool isLoading = false;
  UserModel? user;
  @override
  void onInit() {
    AuthDio.init();
    super.onInit();
    SharePref.init();
  }

  changeShowPassword() {
    isPassword = !isPassword;
    update();
  }

  signup(context) async {
    if (formKey.currentState!.validate()) {
      isLoading = false;
      update();
      userModel = await AuthDio.signUp(
          fullName: name.text,
          email: email.text,
          password: password.text,
          phoneNumber: phone.text);
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userModel!.message!)),
      );

      if (userModel!.status == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userModel!.message!)),
        );
        await Get.offAll(MainScreen());
        await SharePref.init();
        userId = await SharePref.getData(key: 'userId');
        token = await SharePref.getData(key: 'token');
        await Get.offAll(() => MainScreen());
        email.clear();
        password.clear();
        name.clear();
        phone.clear();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(userModel!.message!),
            ));
      }
      update();
    }
  }
  forget(context) async {
    forgetLoginKey.currentState!.save();
      Get.bottomSheet(Container(
        height: 275.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white),
        child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
      ));
      var x = await AuthDio.forget(
          emailForget.text,
          );
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(x.toString()),
      ));
      update();

  }

  loginGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,

    );
    user = await AuthDio.loginSocial(
        social_id: googleUser.id.toString(), type: "Google",email:googleUser.email );
    if (user != null) {
      await SharePref.init();
      userId = await SharePref.getData(key: 'userId');
      token = await SharePref.getData(key: 'token');
      await Get.offAll(() => MainScreen());
      emailLogin.clear();
      passwordLogin.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Try Again")),
      );
    }
    update();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  loginApple(BuildContext context) async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
    );
    UserCredential x= await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    print(x.user!.email);
    print(appleCredential.userIdentifier);
    userModel = await AuthDio.loginSocial(
        social_id:appleCredential.userIdentifier,
        type: "Apple",
        email: x.user!.email);
    if (userModel?.status == 1) {
      userId = await SharePref.getData(key: 'userId');
      token = await SharePref.getData(key: 'token');
      await Get.offAll(() => MainScreen());
      emailLogin.clear();
      passwordLogin.clear();
      print(userModel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userModel!.message!)),
      );
    }
    update();
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  loginFacebook(BuildContext context) async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userDate = await FacebookAuth.instance.getUserData();
      print(userDate);
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.tokenString);
      print(facebookAuthCredential);
      userModel = await AuthDio.loginSocial(
          social_id: userDate['id'],
          type: "Facebook",
          email: userDate['email']);
      print(userModel!.status);
      if (userModel!.status == 1) {
        userId = await SharePref.getData(key: 'userId');
        token = await SharePref.getData(key: 'token');
        await Get.offAll(() => MainScreen());
        emailLogin.clear();
        passwordLogin.clear();
        print(userModel);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userModel!.message!)),
        );
      }

      // userId = await SharePref.getData(key: 'userId');
      // token = await SharePref.getData(key: 'token');
      // print(token);
      // if (userModel!.status == 1) {
      //   await Get.offAll(() => MainScreen());
      //   emailLogin.clear();
      //   passwordLogin.clear();
      //   print(userModel);
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(userModel!.message!)),
      //   );
      // }

      return await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
    } catch (e) {
      print(e);
      // TODO
    }
  }

  login(context) async {
    print(passwordLogin.text);
    if (formLoginKey.currentState!.validate()) {
      isLoading = false;
      update();
      userModel = await AuthDio.login(
        email: emailLogin.text,
        password: passwordLogin.text,
      );
      isLoading = false;

      if (userModel!.status == 1) {
        userId = await SharePref.getData(key: 'userId');
        token = await SharePref.getData(key: 'token');
        await Get.offAll(() => MainScreen());
        emailLogin.clear();
        passwordLogin.clear();
        print(userModel);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userModel!.message!)),
        );
      }
      update();
    }
  }

  loginSocial(context) async {
    print(passwordLogin.text);
    if (formLoginKey.currentState!.validate()) {
      isLoading = false;
      update();
      userModel = await AuthDio.login(
        email: emailLogin.text,
        password: passwordLogin.text,
      );
      isLoading = false;
      if (userModel!.status == 1) {
        SharePref.setData(
            key: "token", data: userModel!.data!.user!.accessToken);
        SharePref.setData(key: "userId", data: userModel!.data!.user!.id);
      }

      userId = await SharePref.getData(key: 'userId');
      token = await SharePref.getData(key: 'token');
      print(token);
      if (userModel!.status == 1) {
        await Get.offAll(() => MainScreen());
        emailLogin.clear();
        passwordLogin.clear();
        print(userModel);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userModel!.message!)),
        );
      }
      update();
    }
  }
// getApiKey() async {
//   String? api_Key = await AuthDio.getApiKey();
//   print(api_Key);
//   apiKey = await SharePref.getData(key: 'apiKey');
//   print(apiKey);
// }
}
