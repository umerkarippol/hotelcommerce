import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hotelHomeController extends GetxController {
  String? SharedpreFcoNtactHotel;
  String? SharedpreFHotelId;

  String? SharedpreFHotelNAMe;

  @override
  void onInit() {
    getStringValuesSF_hOtel();
    // TODO: implement onInit
    super.onInit();
  }

  getStringValuesSF_hOtel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // String? stringValue = prefs.getString('UserTyp');
    SharedpreFcoNtactHotel = prefs.getString('hotelContact');

    SharedpreFHotelId = prefs.getString('HotelID');

    SharedpreFHotelNAMe = prefs.getString('HotelName');
  }
}
