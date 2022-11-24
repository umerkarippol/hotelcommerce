import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/cartcontroller.dart';
import 'package:hotelservice/homeHotel/homescreen.dart';

import '../screen/home/home_user/tab_bar.dart';
import '../screen/home/screen_home.dart';

class scannercontroller extends GetxController {
//
//DROPDOWN

  Listinsertion() {
    int n = 100;
    //List Table = [];

    int tablelegth = total_table_no;
    for (int i = 1; i <= n; i++) {
      if (i <= tablelegth) {
        String i1 = i.toString();
        Table.add(i1);
        log(i.toString());
      } else {
        log('compltd');
      }
    }
  }

  List<String> Table = [];

//

  final FirebaseAuth auth = FirebaseAuth.instance;
  String ScannedQrcode = "";
  String name = 'akash';
  var firebaseId;
  var hotel_detailsfromfire;
  var total_table_no;
  var namefromfire;
  var hotel_id_fromfire;
  var uidd;
  var tax;

  CollectionReference users = FirebaseFirestore.instance.collection('hotels');

  void uid() {
    log('inside the function uid');
    final User? user = auth.currentUser;
    final uid = user?.uid;
    uidd = uid;

    log(uid.toString());
  }

  void getid() async {
    uid();
    var query = users.where('qr_id', isEqualTo: ScannedQrcode).limit(1);
    Stream<QuerySnapshot> snapshot = await query.snapshots();

    snapshot.forEach((field) {
      field.docs.asMap().forEach((index, data) async {
        log(' inside the getid()');
        namefromfire = field.docs[index]['hotel_name'];
        hotel_id_fromfire = field.docs[index]['hotel_id'];
        hotel_detailsfromfire = field.docs[index]['details'];
        tax = field.docs[index]['tax'];
        total_table_no = field.docs[index]['totaltable'];
        log(tax.toString());
        log(namefromfire);
        log(field.docs[index]['hotel_id'].toString());
        if (namefromfire != null) {
          log('""""""""""""""""checked -> contains data""""""""""""""""');
          log(namefromfire);
          Get.defaultDialog(
              title: 'Alert',
              titleStyle: TextStyle(fontSize: 25),
              middleText: namefromfire,
              middleTextStyle: TextStyle(fontSize: 20),
              backgroundColor: Colors.grey,
              radius: 20,
              textCancel: 'Cancel',
              cancelTextColor: Color.fromARGB(255, 125, 31, 24),
              textConfirm: 'Confirm',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Listinsertion();
                Get.to(tabbartest());

                // Get.to(tabbartest(), arguments: [
                //   namefromfire,
                //   hotel_id_fromfire,
                //   hotel_detailsfromfire
                // ]);
              });
        }
      });
    });
  }

  // void getid() async {
  //   print('================getid=======');
  //   String mydoc = ScannedQrcode;

  //   DocumentSnapshot<Object?> documentSnapshot;

  //   await users.doc(mydoc).get().then((value) {
  //     documentSnapshot = value;

  //     firebaseId = documentSnapshot["id"];
  //   });

  //   if (firebaseId == mydoc) {
  //     print("===============success============");

  //     Get.to(tabbartest());

  //     // Get.to(screen_home());
  //   } else {
  //     Get.snackbar('failed to load', 'sorry failed to load content');
  //   }
  // }

  Future<void> ScanQr() async {
    try {
      ScannedQrcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      Get.snackbar('Result', ScannedQrcode,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on PlatformException {}
    ;
    getid();
  }
}
