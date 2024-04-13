import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../controller/profile_controller.dart';

class TermSerivce extends StatefulWidget {
  const TermSerivce({Key? key}) : super(key: key);

  @override
  State<TermSerivce> createState() => _TermSerivceState();
}

class _TermSerivceState extends State<TermSerivce> {
  initState() {
    super.initState();
    ProfileController controller = Get.put(ProfileController());
    controller.getTerm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("termsofService".tr),
      ),
      body: GetBuilder<ProfileController>(builder: (logic) {
        return
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse('http://app.mdc-card.com//api/policy')),
          initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
            ),
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
          ),
          onWebViewCreated: (controller) {
          },
          onLoadStart: (controller, url) {
            print('Page started loading: $url');
          },
          onLoadStop: (controller, url) {
            print('Page finished loading: $url');
          },
        );
      }),
    );
  }
}
