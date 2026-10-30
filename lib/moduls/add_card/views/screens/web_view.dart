import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/add_card/card_controller/card_controller.dart';

/// Payment webview (migrated from webview_flutter to flutter_inappwebview).
/// Detects the payment result by watching for the `status` query param in the
/// navigation URL, then pops back to the app.
class WebViewCheck extends StatelessWidget {
  final String? url;
  WebViewCheck(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment'.tr,
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(child: GetBuilder<CardController>(builder: (logic) {
        return InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url!)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
            ),
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
            ),
          ),
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            final requestUrl = navigationAction.request.url.toString();
            if (requestUrl.startsWith('https://www.youtube.com/')) {
              return NavigationActionPolicy.CANCEL;
            }
            if (requestUrl.split('?').last.split('=').first == "status") {
              logic.redirect = requestUrl.split('?').last.split('=').last;
              Get.back();
              Get.back();
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },
        );
      })),
    );
  }
}
