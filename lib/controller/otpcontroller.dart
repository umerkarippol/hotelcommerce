import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hotelservice/screen/QR_Screen.dart';
import 'package:hotelservice/screen/auth/auth_phone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otpcontroller extends GetxController {
  TextEditingController mobile_auth = TextEditingController();
  // sharedpref controllerss = Get.find();
  // late UserSimplePreferences sharedPreference;
  var auth = FirebaseAuth.instance;
  String codevalue = "";

  var authstate = ''.obs;
  String verificationId = '';

  generate_otp() async {
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: "+91" + mobile_auth.text,
        verificationCompleted: (PhoneAuthCredential creddential) async {
          await auth.signInWithCredential(creddential).then((value) async {
            {
              // if (value.user != null) {
              //   print('user logged in');
              // }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Problem when send the code');
          print(e.message);
        },
        codeSent: (String id, int? resendToken) {
          print("clicked=====");
          this.verificationId = id;
          authstate.value = "login success";
        },
        codeAutoRetrievalTimeout: (id) {
          this.verificationId = id;
        });
  }

  verify_otp(
    String otp,
  ) async {
    log('inside the verify');
    var credential = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId, smsCode: otp));

    if (credential.user != null) {
      log('inside the credential');
      // sharedPreference.saveUser(phone);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserTyp', "user");
      log('user_SharedPref :Suceess');
      prefs.setString('uSerContact', mobile_auth.text);
      log('uSerContact_SharedPref :Suceess');
      Get.to(Qr_screen());

      // controllerss.logindata.setBool('login', false);
    }
  }
}
