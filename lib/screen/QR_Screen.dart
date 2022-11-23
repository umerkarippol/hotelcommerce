import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/otpcontroller.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';

import 'package:hotelservice/screen/auth/auth_phone.dart';

class Qr_screen extends StatelessWidget {
  // sharedpref controllerss = Get.find();

  var auth = FirebaseAuth.instance;
  otpcontroller controllers = Get.find();
  final scannercontroller controller = Get.put(scannercontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("WELCOME", style: TextStyle(fontSize: 30)),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 70.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 13, 120, 213),
      ),

      //  AppBar(
      //   backgroundColor: Color.fromARGB(255, 249, 249, 249),
      //   leading: Text(controllers.authstate()),
      //   title: Center(
      //     child: Text(
      //       'WELCOME',
      //       style: TextStyle(fontSize: 35, color: Colors.black),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //         color: Colors.amber,
      //         onPressed: () async {
      //           await auth.signOut();
      //           Get.to(auth_phone());
      //         },
      //         icon: Icon(Icons.attribution))
      //   ],
      // ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            " “If more of us valued food and cheer and song above hoarded gold, it would be a merrier world.”   ",
            // controller.mobile_auth.text,
            style: TextStyle(
                fontSize: 28,
                color: Color.fromARGB(255, 75, 75, 75),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('― J.R.R. Tolkien      ',
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 13, 120, 213))),
            ],
          ),
          Icon(
            Icons.qr_code_2,
            size: 270,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Color.fromARGB(255, 13, 120, 213),
                // Color.fromARGB(255, 16, 152, 193
                // ),
                child: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      controller.ScanQr();
                    },
                    icon: Icon(Icons.qr_code_scanner)),
              )
            ],
          ),
        ],
      )),
    );
  }
}
