import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/cartcontroller.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/screen/home/home_user/home_product_view.dart';
import 'package:hotelservice/screen/home/home_user/home_product_view.dart';
import 'package:hotelservice/widgets/appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cart/cartfinal.dart';
import '../../auth/auth_phone.dart';

class tabbartest extends StatefulWidget {
  const tabbartest({Key? key}) : super(key: key);

  @override
  State<tabbartest> createState() => tabbartestState();
}

scannercontroller hotelidcontroller1 = Get.put(scannercontroller());
String doc_id = hotelidcontroller1.ScannedQrcode;

class tabbartestState extends State<tabbartest> {
  CartViewModel controllercart = Get.put(CartViewModel());
  scannercontroller controllercart_to_id = Get.put(scannercontroller());

  final _auth = FirebaseAuth.instance;
  // dynamic getid = Get.arguments;

  int _counter = 0;
  // final List<Tab> myTabs = <Tab>[
  //   // new Tab(text: 'Men'),
  //   // new Tab(text: 'Women'),
  //   // new Tab(text: 'Shirt'),
  // ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('hotel_id',
                isEqualTo: controllercart_to_id.hotel_id_fromfire)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<Tab> myTabs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            myTabs.add(new Tab(
              text: a['category_item'],
            ));
            print('tab=====' + myTabs.toString());
            // a['id'] = document.id;
          }).toList();

          return DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              appBar: AppBar(
                // leading: IconButton(
                //     onPressed: () {
                //       Get.defaultDialog(
                //         title: controllercart_to_id.namefromfire,
                //         titleStyle: TextStyle(fontSize: 25),
                //         middleText: controllercart_to_id.hotel_detailsfromfire,
                //         middleTextStyle: TextStyle(fontSize: 20),
                //         backgroundColor: Colors.grey,
                //         radius: 20,
                //         textCancel: 'OK',
                //         cancelTextColor: Color.fromARGB(255, 255, 255, 255),
                //         // textConfirm: 'OK',
                //         // confirmTextColor: Colors.white,
                //         // onConfirm: () {
                //         // Get.to(tabbartest(),
                //         //     arguments: [namefromfire, hotel_id_fromfire]);
                //         // }
                //       );
                //     },
                //     icon: Icon(Icons.info_outlined)),

                //  Icon(Icons.info_sharp),
                title: Center(
                    child: Text(
                  controllercart_to_id.namefromfire,
                  style: TextStyle(fontSize: 27),
                )),
                actions: [
                  Obx(
                    () => Badge(
                      showBadge:
                          controllercart.cartProducts.length > 0 ? true : false,
                      badgeContent: Text(
                        controllercart.cartProducts.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Get.to(cartfinal());
                          },
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            size: 35,
                            color: Colors.amber,
                          )),
                    ),
                  ),
                  IconButton(
                      iconSize: 30,
                      onPressed: () {
                        Get.defaultDialog(
                          backgroundColor: Color.fromARGB(255, 236, 57, 57),
                          title: 'Alert',
                          middleText: 'Are You Sure!\n Do You Want To Logout?',
                          textCancel: 'Cancel',
                          textConfirm: 'Confirm',
                          buttonColor: Color.fromARGB(255, 169, 6, 6),
                          cancelTextColor: Colors.white,
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            //Remove String
                            prefs.clear();
                            log('removed usertyp-user:Success');
                            //Remove bool
                            prefs.remove("uSerContact");
                            log('removed contact:Success');
                            await _auth.signOut();
                            Get.to(auth_phone());
                          },
                        );
                      },
                      icon: Icon(
                        Icons.exit_to_app_outlined,
                        color: Color.fromARGB(255, 255, 17, 0),
                      ))
                ],
                backgroundColor: Color.fromARGB(255, 0, 126, 237),
                bottom: TabBar(
                  tabs: myTabs,
                ),
              ),
              drawer: drawer(),
              body: new TabBarView(
                children: myTabs.map((Tab tab) {
                  print("selected item====" + tab.text.toString());
                  return new ViewProducts(
                    tabitem: tab.text.toString(),
                  );
                  // Center(child: new Text(tab.text.toString()));
                }).toList(),
              ),
              // body: Column(
              //   children: myTabs.map((Tab tab) {
              //     print('tab=12====' + tab.toString());
              //     return
              //         // MenGalleryScreen();

              //         Center(
              //             child: Text(tab.text.toString()
              //                 // tab.text.toString()
              //                 ));
              //   }).toList(),
              // ),
            ),
          );
        });
  }
}
