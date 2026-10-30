import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';

/// Step 2 of the phone-OTP password reset: enter the verification code.
class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (logic) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 22.w),
                  ),
                  SizedBox(height: 30.h),
                  Text('Verification Code',
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text(
                    'Enter the code we sent to ${logic.phoneCountryCode}${logic.forgetPhone.text}',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white70),
                  ),
                  SizedBox(height: 34.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextField(
                      controller: logic.otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      style: TextStyle(fontSize: 24.sp, letterSpacing: 8),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          counterText: '',
                          hintText: '------',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14)),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: logic.resendSeconds > 0
                        ? Text('Resend in ${logic.resendSeconds}s',
                            style: const TextStyle(color: Colors.white70))
                        : TextButton(
                            onPressed: () =>
                                logic.sendOtp(context, isResend: true),
                            child: const Text('Resend Code',
                                style: TextStyle(color: Colors.white)),
                          ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: logic.otpLoading
                          ? null
                          : () => logic.verifyOtp(context),
                      child: logic.otpLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Verify'),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Center(
                    child: TextButton.icon(
                      onPressed: logic.contactAdminWhatsApp,
                      icon: const Icon(Icons.chat, color: Color(0xff25D366)),
                      label: const Text('Having trouble? Contact Admin',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
