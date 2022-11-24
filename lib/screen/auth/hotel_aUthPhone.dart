import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/hotel_authContrlr.dart';
import 'package:hotelservice/screen/auth/hotel_DeTaiLS.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hotel_aUthPhone extends StatelessWidget {
  hotel_aUthPhone({Key? key}) : super(key: key);
  hotel_authController OXcNt = Get.put(hotel_authController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 91, 87),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 130),

            child: RichText(
              text: TextSpan(
                  text: 'Buisness Login ',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(
                        text: '.',
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
                          controller: OXcNt.buiSnsLogMOB,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          style: TextStyle(),
                          // obscureText: true,
                          decoration: InputDecoration(
                              prefixText: '+91',
                              prefixIcon: Icon(Icons.add_call),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Mobile",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                              )),
                        ),
                        Obx(
                          () => Visibility(
                            visible: OXcNt.IsvisibleTex.value,
                            child: TextField(
                              controller: OXcNt.buiSnsLogOtp,
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              style: TextStyle(),
                              // obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security_outlined),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Enter OTP",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Visibility(
                                visible: OXcNt.IsvisibleBUtOtp.value,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  // Color.fromARGB(255, 16, 152, 193
                                  // ),
                                  child: IconButton(
                                      color: Colors.black,
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        prefs
                                            .setString(
                                                'hotelContact', '7736241467')
                                            .whenComplete(() {
                                          Get.to(hotel_DeTaiLS());
                                        });
                                        // OXcNt.generate_otp();
                                        // OXcNt.IsvisibleTex.value = true;
                                        // controller.generate_otp(mobile_auth.text);
                                        // Get.to(auth_verify(
                                        //     // phone: mobile_auth.text,
                                        //     ));
                                      },
                                      icon: Text('OTP')),
                                ),
                              ),
                            ),
                            Obx(() => Visibility(
                                  visible: OXcNt.IsvisibleBUtTik.value,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        color: Colors.black,
                                        onPressed: () {
                                          // OXcNt.verify_otp();
                                        },
                                        icon: Text(
                                          '✓',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 26),
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
