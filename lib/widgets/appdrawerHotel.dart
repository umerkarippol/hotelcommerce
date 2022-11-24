import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/home_DrawerController.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/homeHotel/DrawerHotel/adDaNewCatogory.dart';
import 'package:hotelservice/homeHotel/DrawerHotel/addAnEwProduct.dart';
import 'package:hotelservice/homeHotel/DrawerHotel/qrCodeGen.dart';
import 'package:hotelservice/screen/myorders/MyOrders_.dart';

import '../screen/home/myorders.dart';

class drawerHotel extends StatelessWidget {
  drawerHotel({Key? key}) : super(key: key);
  // scannercontroller controller = Get.put(scannercontroller());
  HomeController homecontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 126, 237),
            ),
            child: Text(
              '\nManage Hotel',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'muli',
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              size: 40,
              color: Colors.amber,
            ),
            title: Text(
              'All Orders',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              // Get.to(mYOrders_());
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              size: 40,
              color: Color.fromARGB(255, 26, 108, 1),
            ),
            title: Text(
              'Add New Product',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              homecontroller.RetrivingCAtegryInit();
              Get.to(AddAnEwProduct());
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.add_to_photos_outlined,
              size: 40,
              color: Color.fromARGB(255, 26, 108, 1),
            ),
            title: Text(
              'Add New Category',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              Get.to(AddAnEWcaTegory());
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.qr_code_2_rounded,
              size: 40,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            title: Text(
              'Manage QR Code',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              Get.to(qRcoDEgeN());
            },
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.info_rounded,
              size: 40,
              color: Color.fromARGB(255, 20, 181, 190),
            ),
            title: Text(' Edit About', style: TextStyle(fontSize: 25)),
            onTap: () {
              Get.defaultDialog(
                title: '',
                titleStyle: TextStyle(fontSize: 25),
                middleText: '',
                middleTextStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.grey,
                radius: 20,
                textCancel: 'OK',
                cancelTextColor: Color.fromARGB(255, 255, 255, 255),
                // textConfirm: 'OK'
                //         // confirmTextColor: Colors.white,
                //         // onConfirm: () {
                //         // Get.to(tabbartest(),
                //         //     arguments: [namefromfire, hotel_id_fromfire]);
                //         // }
                //       );
                //     },
              );
            },
          ),
        ],
      ),
    );
  }
}
