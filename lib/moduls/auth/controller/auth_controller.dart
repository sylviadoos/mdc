import 'dart:async';

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
import 'package:url_launcher/url_launcher.dart';

import '../../../services/api/auth_requests.dart';
import '../../../services/local_data/share_pref.dart';
import '../view/screen/login.dart';
import '../view/screen/otp_screen.dart';
import '../view/screen/new_password_screen.dart';

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

  // ===================== FORGOT PASSWORD via PHONE OTP =====================
  final TextEditingController forgetPhone = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  void toggleNewPassword() {
    showNewPassword = !showNewPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }
  String phoneCountryCode = '+973';
  String? _verificationId;
  String? _idToken;
  bool otpLoading = false;
  int resendSeconds = 0;
  Timer? _resendTimer;

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// Opens WhatsApp chat with the admin support number.
  Future<void> contactAdminWhatsApp() async {
    final url = "https://wa.me/+97366903009/?text=Hello, I need help resetting my password.";
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void _startResendTimer() {
    resendSeconds = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (resendSeconds <= 0) {
        t.cancel();
      } else {
        resendSeconds--;
      }
      update();
    });
  }

  /// Step 1: send the OTP to the entered phone number via Firebase Phone Auth.
  Future<void> sendOtp(BuildContext context, {bool isResend = false}) async {
    final local = forgetPhone.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (local.isEmpty) {
      _snack(context, 'Please enter your phone number');
      return;
    }
    final fullNumber = '$phoneCountryCode$local';
    otpLoading = true;
    update();

    // Make sure the number is registered before sending any OTP.
    if (!isResend) {
      final exists = await AuthDio.checkPhoneExists(fullNumber);
      if (exists == null) {
        // Couldn't reach the server — don't mislead the user.
        otpLoading = false;
        update();
        _snack(context,
            'Connection error. Please check your internet and try again.');
        return;
      }
      if (exists == false) {
        otpLoading = false;
        update();
        showContactAdminSheet(context,
            message:
                'This phone number is not registered in our system. Please contact the admin.');
        return;
      }
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Android auto-retrieval: sign in directly.
        await _signInAndProceed(credential, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        otpLoading = false;
        update();
        _snack(context, e.message ?? 'Verification failed. Please try again.');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        otpLoading = false;
        _startResendTimer();
        update();
        if (!isResend) {
          Get.to(() => OtpScreen());
        } else {
          _snack(context, 'A new code has been sent.');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  /// Step 2: verify the code the user typed.
  Future<void> verifyOtp(BuildContext context) async {
    if (_verificationId == null) {
      _snack(context, 'Session expired, please request a new code.');
      return;
    }
    final code = otpController.text.trim();
    if (code.length < 4) {
      _snack(context, 'Please enter the code you received');
      return;
    }
    otpLoading = true;
    update();
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: code);
      await _signInAndProceed(credential, context);
    } on FirebaseAuthException catch (e) {
      otpLoading = false;
      update();
      _snack(
          context,
          e.code == 'invalid-verification-code'
              ? 'The code is incorrect. Please try again.'
              : (e.message ?? 'Verification failed.'));
    }
  }

  Future<void> _signInAndProceed(
      PhoneAuthCredential credential, BuildContext context) async {
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);
    _idToken = await userCred.user?.getIdToken();
    otpLoading = false;
    update();
    if (_idToken != null) {
      Get.to(() => NewPasswordScreen());
    } else {
      _snack(context, 'Could not verify. Please try again.');
    }
  }

  /// Step 3: send the new password + verified token to the backend.
  Future<void> submitNewPassword(BuildContext context) async {
    if (newPassword.text.length < 6) {
      _snack(context, 'Password must be at least 6 characters');
      return;
    }
    if (newPassword.text != confirmPassword.text) {
      _snack(context, 'Passwords do not match');
      return;
    }
    if (_idToken == null) {
      _snack(context, 'Session expired, please start again.');
      return;
    }
    otpLoading = true;
    update();
    final res = await AuthDio.resetPasswordPhone(
        idToken: _idToken!, newPassword: newPassword.text);
    otpLoading = false;
    update();

    if (res['status'] == 1) {
      _clearForgetFields();
      // Overlay snackbar survives navigation; then go straight to login.
      Get.snackbar('Success',
          res['message']?.toString() ?? 'Password updated. Please log in.',
          backgroundColor: const Color(0xff00416B),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => LoginScreen());
    } else if (res['code'] == 'not_matched') {
      // Phone not linked to an account -> offer admin contact.
      showContactAdminSheet(context,
          message: res['message']?.toString() ??
              "We couldn't match this number to an account.");
    } else {
      _snack(context, res['message']?.toString() ?? 'Something went wrong.');
    }
  }

  void showContactAdminSheet(BuildContext context, {required String message}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Color(0xff00416B), size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff25D366)),
                onPressed: contactAdminWhatsApp,
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text('Contact Admin on WhatsApp',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearForgetFields() {
    forgetPhone.clear();
    otpController.clear();
    newPassword.clear();
    confirmPassword.clear();
    _verificationId = null;
    _idToken = null;
    _resendTimer?.cancel();
  }
  // =================== END FORGOT PASSWORD via PHONE OTP ===================

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

      // Network / server error -> AuthDio returned null. Don't crash.
      if (userModel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Connection error. Please check your internet and try again.')),
        );
        update();
        return;
      }

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
