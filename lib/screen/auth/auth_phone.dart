import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/otpcontroller.dart';

import 'package:hotelservice/screen/auth/auth_verify_otp.dart';
import 'package:hotelservice/screen/auth/hotel_aUthPhone.dart';
import 'package:hotelservice/screen/auth/hotel_registr.dart';

class auth_phone extends StatelessWidget {
  otpcontroller oTpContrl = Get.put(otpcontroller());

  otpcontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 114, 113, 113),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 130),

            child: RichText(
              text: TextSpan(
                  text: 'Welcome',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'back!',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w800))
                  ]),
            ),

            // child: Text(
            //   'Welcome\nBack!',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     fontSize: 43,
            //   ),
            // ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        // Text(
                        //   'Enter Your Mobile Number',
                        //   style: TextStyle(
                        //       fontSize: 30, fontWeight: FontWeight.w500),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.dialpad_rounded,
                            size: 60,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: oTpContrl.mobile_auth,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          style: TextStyle(),
                          // obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.add_call),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Mobile",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Sign',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w900),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: "in",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Color.fromARGB(
                                              255, 178, 177, 177)))
                                ])),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              // Color.fromARGB(255, 16, 152, 193
                              // ),
                              child: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    controller.generate_otp();
                                    Get.to(auth_verify(
                                        // phone: mobile_auth.text,
                                        ));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {
                    Get.to(hotel_aUthPhone());
                  },
                  child: Text(
                    'Hotel Login',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  )))
        ],
      ),
    );
  }
}
