import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/screen/myorders/MyOrders_.dart';

import '../screen/home/myorders.dart';

class drawer extends StatelessWidget {
  drawer({Key? key}) : super(key: key);
  scannercontroller controller = Get.put(scannercontroller());

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
              '\nWelcome To \n ' + controller.namefromfire,
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
              'My Orders',
              style: TextStyle(fontSize: 25),
            ),
            onTap: () {
              Get.to(mYOrders_());
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
            title: Text('About Us', style: TextStyle(fontSize: 25)),
            onTap: () {
              Get.defaultDialog(
                title: controller.namefromfire,
                titleStyle: TextStyle(fontSize: 25),
                middleText: controller.hotel_detailsfromfire,
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
