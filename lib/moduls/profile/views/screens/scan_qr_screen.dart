import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../offer/views/screens/qr_details_offer_screen.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? result2;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 5,
              ),
            ),
          ),
          Center(
            child: (result2 != null && result2 != 'Not Correct Data.')
                ? GetBuilder<OffersController>(builder: (logic) {
                    return ElevatedButton(
                        onPressed: () async {
                          Get.off(() => QrDetailsOffer());
                          await logic.getDetailsServices(
                              offerController.offersModelWithQR!.data!.id!);
                        },
                        child: SizedBox(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'takeTheOffer'.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.4),
                              ),
                              Icon(
                                Icons.start,
                                color: Colors.white,
                                size: 17,
                              )
                            ],
                          ),
                        ));
                  })
                : (result2 == null)
                    ? Container()
                    : ElevatedButton(
                        onPressed: () {
                          controller?.resumeCamera();
                        },
                        child: SizedBox(
                          width: 120,
                          child: Text(
                            'tryAgain'.tr,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.4),
                          ),
                        )),
          )
        ],
      ),
    );
  }

  var offerController = Get.put(OffersController());

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      reassemble();

      await offerController.getOfferQRCode(scanData.code);

      // print('response${offerController.offersModelWithQR?.message}');
      if (offerController.offersModelWithQR != null) {
        if (offerController.offersModelWithQR!.message == 'Data not found.') {
          result2 = 'Not Correct Data.';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result2!)),
          );
        } else {
          result2 = scanData.code.toString();
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
