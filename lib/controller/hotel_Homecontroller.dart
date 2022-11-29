import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hotelHomeController extends GetxController {
  String? SharedpreFcoNtactHotel;
  String? SharedpreFHotelId;

  String? SharedpreFHotelNAMe;
  List<String> category = [];
  @override
  void onInit() {
    log('inside the inint');
    RetrivingCAtegryInit();
    getStringValuesSF_hOtel();
    // TODO: implement onInit
    super.onInit();
  }

  getStringValuesSF_hOtel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // String? stringValue = prefs.getString('UserTyp');
    SharedpreFcoNtactHotel = prefs.getString('hotelContact');
    log(SharedpreFcoNtactHotel.toString());

    SharedpreFHotelId = prefs.getString('HotelID');
    log(SharedpreFHotelId.toString());
    SharedpreFHotelNAMe = prefs.getString('HotelName');
    log(SharedpreFHotelNAMe.toString());
    return SharedpreFHotelId;
  }

  RetrivingCAtegryInit() async {
    log(SharedpreFHotelId.toString() +
        "[hotel id++++++++++++++++++++++++++++++++++");
    FirebaseFirestore.instance
        .collection('category')
        .where('hotel_id',
            isEqualTo: SharedpreFHotelId == null ? 'null' : SharedpreFHotelId
            //  SharedpreFHotelId
            )
        .get()
        .then((snapshot) {
      category.clear();
      snapshot.docs.forEach((doc) {
        log(doc['category_item'].toString() + "before retriving");

        category.add(doc['category_item']);
      });
    });

    // for (int i = 0; i <= category.length; i++) {
    //   log(category.toString());
    // }
  }
}
