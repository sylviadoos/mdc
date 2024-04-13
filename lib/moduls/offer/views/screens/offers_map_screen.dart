import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mdc_card/moduls/offer/controllers/offer_controller.dart';

class OffersMapScreen extends StatefulWidget {
  OffersMapScreen({Key? key}) : super(key: key);

  @override
  State<OffersMapScreen> createState() => _OffersMapScreenState();
}

class _OffersMapScreenState extends State<OffersMapScreen> {
  final OffersController _placesController = Get.put(OffersController());

  @override
  void initState() {
   // _placesController.getCurrentLocation();

  getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_placesController.offersModel!.data!.length);
    // print('_placesController.center${_placesController.center}');
    return Scaffold(
      body: GetBuilder<OffersController>(
          init: OffersController(),
          builder: (logic) {
            print('logic.center${logic.center}');
            return Stack(
              children: [
                GoogleMap(

                  onMapCreated: logic.onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: logic.center,
                    zoom: 11,
                  ),
                    markers:logic.markers_// Set<Marker>.from(logic.myMarker),

                ),
                // Positioned(
                //     top: 2,
                //     child: RepaintBoundary(
                //       key: logic.iconDropKey,
                //       child: Container(
                //           color: Colors.red,
                //           child: Text('dd')),
                //     ))
              ],
            );
          }),
    );
  }

  Future<void> getMarkers() async {

    await _placesController.getMarkerIcon(80);
    setState(() {

    });
  }
}
