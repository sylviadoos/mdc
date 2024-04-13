import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:mdc_card/moduls/offer/models/get_all_user_offers.dart';
import 'package:mdc_card/moduls/offer/models/offers_details.dart';
import 'package:mdc_card/moduls/offer/models/services_details.dart';
import 'package:mdc_card/moduls/offer/models/services_model.dart';
import 'package:mdc_card/moduls/offer/models/take_offer.dart';
import 'package:mdc_card/services/api/main_requests.dart';
import 'package:mdc_card/shared/constant.dart';

import '../../../shared/accept_request.dart';
import '../../add_card/views/screens/web_view.dart';
import '../../main/controller/main_controller.dart';
import '../models/offer_payment.dart';
import '../models/offers_model.dart';
import '../models/qr_offers_model.dart';
import '../models/take_rate_qr_offer.dart';
import '../views/screens/details_services.dart';

class OffersController extends GetxController {
  ServicesModel? servicesModel;
  OffersModel? offersModel;
  AllUserOffers? allUserOffersMain;
  TakeOfferModel? takeOfferModel;
  OffersDetailsModel? detailsOffersModel;
  DetailsServicesModel? detailsServicesModel;
  DetailsServicesModel? detailsDirctoryModel;
  QrOffersModel? offersModelWithQR;
  TakeAndRateQrOfferModel? takeAndRateQrOfferModel;
  bool isLoading = false;
  int expandedList = 0;
  String? redirect;
  List myMarker = [];
  GlobalKey iconDropKey = GlobalKey();
  Set<Marker> markers_ = {};

  @override
  void onInit() {
    getServices();
    getOffers();

    // getCurrentLocation();

    MainDio.init();
    super.onInit();
  }

  getServices() async {

    isLoading = true;
    update();
    if(Get.find<MainController>().filterText != ''){
      servicesModel = await MainDio.getFilterOffers(Get.find<MainController>().filterText!,Get.find<MainController>().country!);}else{
      servicesModel = await MainDio.getServices(Get.find<MainController>().country!);}
    isLoading = false;
    update();
    // print(servicesModel!.message);
    // servicesModel = await MainDio.getServices(Get.find<MainController>().country!);
    // isLoading = false;
    // update();
    // print(servicesModel!.message);
  }

  getOffers() async {
    isLoading = true;
    update();
    offersModel = await MainDio.getOffers();
    allUserOffersMain = await MainDio.getAllUserOffers();

    if (allUserOffersMain != null && allUserOffersMain!.data != null) {
      allUserOffersMain!.data!.forEach((element) {
        for (int i = 0; i < offersModel!.data!.length; i++)
          if (element.id == offersModel!.data![i].id) {
            offersModel!.data![i].offerTaken = true;
          }
      });
    }
    isLoading = false;
    update();
    print('offersModel!.data');
  }

  takeOffer(BuildContext context, offerId, price) async {
    Get.bottomSheet(Container(
      height: 275.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ));

    {
      OfferPaymentModel? offerPaymentModel = await MainDio.offerPayment(price);
      if (offerPaymentModel!.result!.url != null) {
        print(offerPaymentModel.result!.url);
        Get.back();
        Get.to(WebViewCheck(offerPaymentModel.result!.url));
        if (redirect == 'failed') {
          Get.back();
          Get.bottomSheet(AcceptRequest(
              img: 'assets/images/error.png', title: 'failed'.tr));
        } else if (redirect == 'success') {
          takeOfferModel = await MainDio.getTakeOffer(offerId);
          Get.bottomSheet(AcceptRequest(
            img: 'assets/images/img_21.png',
            title: 'requestAccept'.tr,
          ));
        } else if (redirect == 'failed') {
          Get.bottomSheet(AcceptRequest(
              img: 'assets/images/error.png', title: 'failed'.tr));
        }
      } else if (offerPaymentModel.result!.url == null) {
        Get.bottomSheet(
            AcceptRequest(img: 'assets/images/error.png', title: 'failed'.tr));
      }
      update();
    }
  }

  useOfferInHospital(
    BuildContext context,
    offerId,
  ) async {
    TakeOfferModel? useOfferModel = await MainDio.useOfferInHospital(offerId);

    {
      if (useOfferModel!.message == 'Offer used Successfully') {
        Get.bottomSheet(AcceptRequest(
          img: 'assets/images/img_21.png',
          title: 'requestAccept'.tr,
        ));
update();
      } else if (useOfferModel.message != 'Offer used Successfully') {
        Get.bottomSheet(
            AcceptRequest(img: 'assets/images/error.png', title: 'failed'.tr));
      }
    }
    update();
  }

  getOffersFilter(String filter) async {
    servicesModel = await MainDio.getFilterOffers(filter,Get.find<MainController>().country!);
    update();
    // print(offersModel!.message);
  }

  getDirectoryFilter(String filter) async {
    //print('object');
  //  print(filter);
    servicesModel = await MainDio.getFilterOffers(filter,Get.find<MainController>().country!);
    update();

  //  print(servicesModel!.data![2].addressLatitude);
  }

  getDetailsServices(int id) async {
    isLoading = true;
    update();
    print('getDetailsServices');
    // userId = await SharePref.getData(key: 'userId');
    print(userId);
    print('idid$id');
    detailsServicesModel = await MainDio.getServicesDetails(id);
    isLoading = false;
    update();
  }

  getDetailsOffer(int id) async {
    isLoading = true;
    update();
    print('getDetailsOffer');
    // userId = await SharePref.getData(key: 'userId');
    print(userId);
    print('idid$id');
    detailsOffersModel = await MainDio.getOffersDetails(id);
    isLoading = false;
    update();
  }

  getDetailsDirctory(int id) async {
    isLoading = true;
    update();
    print('getDetailsDirctory');
    detailsServicesModel = await MainDio.getDirctoryDetails(id);
    isLoading = false;
    update();
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  LatLng center = LatLng(26.2028629, 50.56517040000001);
  late BitmapDescriptor markerIcon;

  onMapCreated(
    GoogleMapController controller,
  ) async {
    try {
      await getMarkerIcon(80);
    } catch (e) {
      // Handle location permission errors
      print('Error: $e');
    }
  }

  getCurrentLocation() async {
    Position currentPosition = await checkLocationPermission();
    center = LatLng(currentPosition.latitude, currentPosition.longitude);
    print('center$center');
    update();
    update();
  }

  Future<Position> checkLocationPermission() async {
    print('checkLocationPermission');
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      // Handle this case as needed
      // return Future.error('Location services are disabled');
      print('Location services are disabled');
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permission is denied
      // Request location permission
      print('Request location permission');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permission is still denied after requesting
        // Handle this case as needed
        return Future.error('Location permission is denied');
      }
    }

    // Check if location permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      // Location permission is permanently denied
      // Handle this case as needed
      return Future.error('Location permission is permanently denied');
    }

    // Location permission is granted
    // Fetch the current position
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return currentPosition;
  }
  _capturePng(GlobalKey iconKeys) async {
    dynamic bitmap;

    try {
      RenderRepaintBoundary boundary =
      iconKeys.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      bitmap = BitmapDescriptor.fromBytes(pngBytes);
      // return pngBytes;
    } catch (e) {
      debugPrint(e.toString());
    }
    return bitmap;
  }

   updateMarkers() async {
     var testIcon = await _capturePng(iconDropKey);

     markers.clear();
     markers_.clear();
    for (int i = 0; i < servicesModel!.data!.length; i++) {
      if(servicesModel!.data![i].addressLatitude != null) {
        // print('object');
        // print(servicesModel!.data![i].addressLatitude.toString());
        final LatLng position = LatLng(
            double.parse(servicesModel!.data![i].addressLatitude),
            double.parse(servicesModel!.data![i].addressLongitude));
        markers_.addLabelMarker(LabelMarker(
     label: servicesModel!.data![i].name!,
          markerId:  MarkerId('place_$i'),
          position: position,onTap: () async {
          Get.to(() => DetailsServices());
          await getDetailsServices(
              servicesModel!.data![i].id!);
        },
     backgroundColor: Colors.green,
     )).then((value) {


            update();});
        // myMarker.add(Marker(
        //     markerId:  MarkerId('place_$i'),
        //     icon: testIcon,
        //     position: position,onTap: () async {
        //   Get.to(() => DetailsServices());
        //   await getDetailsServices(
        //       servicesModel!.data![i].id!);
        // }));
      }
     // markers[MarkerId('place_$i')] = marker;
    }

    update();
  }
  // Future<String> getPlaceName(LatLng position) async {
  //   final apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';
  //   final url =
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';
  //
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final decodedResponse = json.decode(response.body);
  //     if (decodedResponse['results'].isNotEmpty) {
  //       return decodedResponse['results'][0]['formatted_address'];
  //     }
  //   }
  //   return 'Unknown Place';
  // }
  getMarkerIcon(double size) async {
    final Uint8List markerIconData = await getBytesFromAsset(
      'assets/images/offer.png',
      width: size.toInt(),
      height: size.toInt(),
    );
    markerIcon = BitmapDescriptor.fromBytes(markerIconData);
    updateMarkers();
  }

  Future<Uint8List> getBytesFromAsset(String path,
      {int width = 100, int height = 100}) async {
    final byteData = await rootBundle.load(path);
    final codec = await instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    final frameInfo = await codec.getNextFrame();
    final image = await frameInfo.image.toByteData(format: ImageByteFormat.png);
    return image!.buffer.asUint8List();
  }

  getOfferQRCode(qrText) async {
    offersModelWithQR = await MainDio.getOffersQRCode(qrText);

    print(offersModelWithQR!.message);
    update();
  }

  postSelectedServiceQRCodeAndRate(serviceId, hospitalId, userRate) async {
    takeAndRateQrOfferModel = await MainDio.postSelectedServiceQRCodeAndRate(
        serviceId, hospitalId, userRate);

    print(takeAndRateQrOfferModel!.message);
    update();
  }
}
