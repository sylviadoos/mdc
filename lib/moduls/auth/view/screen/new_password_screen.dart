import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/auth/controller/auth_controller.dart';

/// Step 3 of the phone-OTP password reset: set a new password.
class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

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
                  Text('New Password',
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 12.h),
                  Text('Choose a new password for your account.',
                      style: TextStyle(fontSize: 15.sp, color: Colors.white70)),
                  SizedBox(height: 34.h),
                  _field(
                      label: 'New Password',
                      controller: logic.newPassword,
                      obscure: !logic.showNewPassword,
                      onToggle: logic.toggleNewPassword),
                  SizedBox(height: 18.h),
                  _field(
                      label: 'Confirm Password',
                      controller: logic.confirmPassword,
                      obscure: !logic.showConfirmPassword,
                      onToggle: logic.toggleConfirmPassword),
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: logic.otpLoading
                          ? null
                          : () => logic.submitNewPassword(context),
                      child: logic.otpLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Update Password'),
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

  Widget _field(
      {required String label,
      required TextEditingController controller,
      required bool obscure,
      required VoidCallback onToggle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 15, color: Colors.white)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
                hintText: '••••••',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: IconButton(
                  icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey),
                  onPressed: onToggle,
                )),
          ),
        ),
      ],
    );
  }
}
