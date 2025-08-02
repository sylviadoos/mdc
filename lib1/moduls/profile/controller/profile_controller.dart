import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdc_card/moduls/auth/view/screen/login.dart';
import 'package:mdc_card/moduls/main/controller/main_controller.dart';
import 'package:mdc_card/moduls/profile/models/profile_model.dart';
import 'package:mdc_card/services/api/auth_requests.dart';
import 'package:mdc_card/services/api/main_requests.dart';
import 'package:mdc_card/services/local_data/share_pref.dart';

import '../../offer/models/services_model.dart';
import '../models/notification_model.dart';

class ProfileController extends GetxController {
  TextEditingController? email = TextEditingController();
  TextEditingController? name = TextEditingController();
  TextEditingController? phone = TextEditingController();
  TextEditingController? city = TextEditingController();
  TextEditingController? fullName = TextEditingController();
  TextEditingController? emailContact = TextEditingController();
  TextEditingController? messageContact = TextEditingController();
  TextEditingController? address = TextEditingController();
  GlobalKey<FormState> keyContact = GlobalKey<FormState>();
  String? gender = 'Male';
  NotificationModel? notificationModel;
  String? birthday;
  String? country;
  ProfileModel? profileModel;

  String? message;
  bool loading = false;
  XFile? _image;
  String? type = "Complains";

  XFile? get image => _image;
  bool isLoading = false;
  String? term;

  changeGroupValue(String s) {
    type = s;
  }

  Future<void> showPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text('PhotoLibrary'.tr),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Camera'.tr),
                    onTap: () async {
                      await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  changeGender(String x) async {
    gender = x;
    profileModel!.data!.gender = x;
    update();
  }

  contactUs(context) async {
    var messages = await MainDio.postContact(
        massage: messageContact!.text,
        name: fullName!.text,
        email: emailContact!.text,
        type: type);
    print(type);
    Get.dialog(AlertDialog(
      title: Text("MDC"),
      content: Text(messages!),
      actions: [
        InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.close,
                  size: 20,
                )))
      ],
    ));
  }

  changeBirthDay(String x) async {
    birthday = x;
    profileModel!.data!.birthDate = x;
    print(birthday);
    update();
  }

  changeCountry(String x) async {
    country = x;
    profileModel!.data!.country = x;
    update();
  }

  getNoitifactions() async {
    isLoading = true;
    notificationModel = await MainDio.getNotifations();
    isLoading = false;
    print(notificationModel!.data);
    update();
  }

  changeImage() async {
    try {
      print(birthday == null ? profileModel!.data!.birthDate : birthday);
      print(address);
      isLoading = true;
      var result = await AuthDio.editProfile(
        phone:
            phone!.text == "" ? profileModel!.data!.phoneNumber : phone!.text,
        image: image!,
        email: email!.text == "" ? profileModel!.data!.email : email!.text,
        name: name!.text == "" ? profileModel!.data!.fullname : name!.text,
        address:
            address!.text == "" ? profileModel!.data!.address : address!.text,
        city: city!.text == "" ? profileModel!.data!.city : city!.text,
        country: profileModel!.data!.country == ""
            ? profileModel!.data!.country
            : country,
        gender: gender == null ? profileModel!.data!.gender! : gender,
        brithday: birthday == null ? profileModel!.data!.birthDate : birthday,
      );
      if (result!.data != null) {
        profileModel = result;
      }
      if (profileModel!.status == 1) {
        Get.snackbar("Done", profileModel!.message!);
        getProfile();
      }
    } catch (e) {
      // TODO
      print(e);
      isLoading = false;
    }
    isLoading = false;
    update();
  }

  getTerm() async {
    term = await AuthDio.getTerm();
    update();
  }

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 350,
        maxWidth: 550);

    _image = image;

    update();
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 350,
        maxWidth: 550);

    _image = image;
    print(image!.path);
    update();
  }

  getProfile() async {
    loading = true;
    update();
    profileModel = await AuthDio.getProfile();
    loading = false;
    print(profileModel!.message);
    update();
  }


  void onInit() {
    AuthDio.init();
    super.onInit();
    getTerm();
  }

  logout() async {
    message = await AuthDio.logout();
    await SharePref.init();
    await SharePref.removeKey('token');
    await SharePref.removeKey('userId');
    Get.put(MainController()).onItemTapped(0);
    Get.offAll(() => LoginScreen());
    update();
  }

  onReady() {}
}
