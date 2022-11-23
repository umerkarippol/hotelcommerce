import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:hotelservice/controller/otpcontroller.dart';

import 'package:hotelservice/screen/QR_Screen.dart';

class auth_verify extends StatelessWidget {
  // auth_verify({
  //   required this.phone,
  // });
  // String phone;
  TextEditingController otp = TextEditingController();
  otpcontroller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 93, 33, 104),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: otp,
              maxLength: 6,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20),
              // obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          RaisedButton(
              onPressed: () {
                controller.verify_otp(
                  // phone,
                  otp.text,
                );
              },
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ))
        ],
      ),
    );
  }
}
