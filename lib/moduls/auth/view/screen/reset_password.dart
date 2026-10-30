import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';

/// Step 1 of the phone-OTP password reset: enter the phone number.
class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

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
                  Text('Forgot Password',
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text(
                    'Enter your phone number and we will send you a verification code.',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white70),
                  ),
                  SizedBox(height: 34.h),
                  Text('Phone Number',
                      style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      // Country code
                      Container(
                        width: 78.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          initialValue: logic.phoneCountryCode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          onChanged: (v) => logic.phoneCountryCode =
                              v.startsWith('+') ? v : '+$v',
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12)),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextField(
                            controller: logic.forgetPhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                hintText: '3XXXXXXX',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: logic.otpLoading
                          ? null
                          : () => logic.sendOtp(context),
                      child: logic.otpLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Send Code'),
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
