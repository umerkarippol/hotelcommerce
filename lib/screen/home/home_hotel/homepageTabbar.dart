import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/hotel_Homecontroller.dart';
import 'package:hotelservice/screen/home/home_hotel/viewTab.dart';
import 'package:hotelservice/widgets/appdrawerHotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HOmePageTabbar extends StatefulWidget {
  const HOmePageTabbar({Key? key}) : super(key: key);

  @override
  State<HOmePageTabbar> createState() => _HOmePageTabbarState();
}

class _HOmePageTabbarState extends State<HOmePageTabbar> {
  hotelHomeController homeControllels = Get.put(hotelHomeController());

  String? SharedpreFHotelId;
  @override
  void initState() {
    retriv();
    log('inside the inintstate in hotelHomeController');
    print('hello inint in hotel home tab');

    print('hello inint in hotel home tab');
    //Get.find<hotelHomeController>().RetrivingCAtegryInit();

    // TODO: implement initState
    super.initState();
  }

  retriv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // String? stringValue = prefs.getString('UserTyp');

    setState(() {
      SharedpreFHotelId = prefs.getString('HotelID');
    });
  }

  @override
  Widget build(BuildContext context) {
    // retriv();
    log('{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{' +
        SharedpreFHotelId.toString());
    Get.find<hotelHomeController>().getStringValuesSF_hOtel();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('category')
            .where('hotel_id', isEqualTo: SharedpreFHotelId)
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
                backgroundColor: Color.fromARGB(255, 21, 114, 244),
                elevation: 0,
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
                  homeControllels.SharedpreFHotelNAMe.toString(),
                  style: TextStyle(fontSize: 27),
                )),
                actions: <Widget>[
                  IconButton(
                      onPressed: () async {
                        // await _auth.signOut();

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.remove("UserTyp");
                        log('hotelsharedpreferenceremovedsuccessfully');
                        prefs.remove("hotelContact");
                        log('hotelsharedpreferenceremovedsuccessfully[Mobile]');
                      },
                      icon: Icon(Icons.logout_outlined))
                ],

                // backgroundColor: Color.fromARGB(255, 0, 126, 237),
                bottom: TabBar(
                  labelColor: Colors.redAccent,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  tabs: myTabs,
                ),
              ),
              drawer: drawerHotel(),
              body: new TabBarView(
                children: myTabs.map((Tab tab) {
                  print("selected item====" + tab.text.toString());
                  return new ViewTabHome(
                    tabitem: tab.text.toString(),
                    hotelId: homeControllels.SharedpreFHotelId.toString(),
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
