import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelservice/homeHotel/homescreen.dart';
import 'package:hotelservice/screen/auth/hotel_DeTaiLS.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class hotel_authController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
//Hotel BuisnesAuth
  String? SharedpreFcoNtactHotel;
  String? SharedpreFHotelId;

  String? SharedpreFHotelNAMe;
  @override
  void onInit() {
    getStringValuesSF_hOtel();
    // TODO: implement onInit
    super.onInit();
  }

  String? hotelId;
  var auth = FirebaseAuth.instance;
  String codevalue = "";

  var authstate = ''.obs;
  String verificationId = '';
  RxBool IsvisibleBUtOtp = true.obs;
  RxBool IsvisibleBUtTik = false.obs;
  RxBool IsvisibleTex = false.obs;
  TextEditingController buiSnsLogMOB = TextEditingController();
  TextEditingController buiSnsLogOtp = TextEditingController();

//
  RxnString errorTextpass = RxnString(null);
  RxnString errorTextdataContains = RxnString(null);

  // var formKey_signUp = GlobalKey<FormState>();
  var formKey_signIn = GlobalKey<FormState>();

  void submit_signIn() {
    if (formKey_signIn.currentState!.validate()) {
      // log("kkkkkkkkkkkkkk");
      upload();
    } else {
      Get.snackbar('Alert', 'Fill The Required Feilds',
          backgroundColor: Colors.red);
    }
    // final isValid = formKey_signIn.currentState!.validate();
    // if (!isValid) {
    //   log('inside form validation');

    //   upload();
    // }
    // formKey_signIn.currentState!.save();
  }

  // void submit_signUp() {
  //   final isValid = formKey_signUp.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   formKey_signUp.currentState!.save();
  // }

  // conTainsData_Check(String? value1) {
  //   // errorTextdataContains.value = "";
  //   log("value 0000000000 ====" + value1!);
  //   if (value1.isEmpty) {
  //     return errorTextdataContains.value = ('*Required To fill this Feild');
  //   }
  //   return null;
  // }

  // Password_checkSignUP(value) {
  //   errorTextpass.value = "";
  //   log('password:' + password.text);
  //   log('confirmpassword:' + confirmpassword.text);
  //   RegExp regex =
  //       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  //   var passNonNullValue = value ?? "";
  //   if (value!.isEmpty) {
  //     return errorTextpass.value = 'Enter a valid password!';
  //   } else if (value.length < 5) {
  //     log('min 5 chars checking ');
  //     return errorTextpass.value = 'min. 5 chars';
  //   } else if (!regex.hasMatch(passNonNullValue)) {
  //     return errorTextpass.value =
  //         ('Password should contain upper,lower,digit and Special character');
  //   } else if (password.text.trim() != confirmpassword.text.trim()) {
  //     log('Password matching  checking compleated');
  //     return errorTextpass.value = 'Password Does not match!';
  //   }
  //   return null;
  // }

  Password_checkSignIn(value) {
    errorTextpass.value = "";
    log('password:' + password.text);
    log('confirmpassword:' + confirmpassword.text);
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue = value ?? "";
    if (value!.isEmpty) {
      return errorTextpass.value = 'Enter a valid password!';
    } else if (value.length < 5) {
      log('min 5 chars checking ');
      return errorTextpass.value = 'min. 5 chars';
    } else if (!regex.hasMatch(passNonNullValue)) {
      return errorTextpass.value =
          ('Password should contain upper,lower,digit and Special character');
    } else if (password.text.trim() != confirmpassword.text.trim()) {
      log('Password matching  checking compleated');
      return errorTextpass.value = 'Password Does not match!';
    }
    return null;
  }

//
//Hotel BuisnesAuth

  generate_otp() async {
    log('generate clicked');
    // log('pppppppppppppppppppppppppppppppp' + buiSnsLogMOB.text);
    await auth.verifyPhoneNumber(
        // timeout: Duration(),
        phoneNumber: "+91" + buiSnsLogMOB.text,
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
          log(e.toString());
          log('insde verificationFailed');
          Get.snackbar('Error', 'Problem when send the code');
          print(e.message);
        },
        codeSent: (String id, int? resendToken) {
          IsvisibleBUtOtp.value = false;
          IsvisibleBUtTik.value = true;
          IsvisibleTex.value = true;
          print("clicked=====");
          this.verificationId = id;
          authstate.value = "login success";
          log('inside success code sent');
        },
        codeAutoRetrievalTimeout: (id) {});
  }

  verify_otp() async {
    log('inside the verify');
    log('OTP:' + buiSnsLogOtp.text);
    var credential = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId, smsCode: buiSnsLogOtp.text));

    if (credential.user != null) {
      log('inside the credential');

      log('inside the sharedpref');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('hotelContact', buiSnsLogMOB.text).whenComplete(() {
        Get.to(hotel_DeTaiLS());
      });

      // controllerss.logindata.setBool('login', false);
    }
  }

  getStringValuesSF_hOtel() async {
    log('inside Sharedpref ///RETRIVING CONTACT DETAILS OF HOTEL...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // String? stringValue = prefs.getString('UserTyp');
    SharedpreFcoNtactHotel = prefs.getString('hotelContact');
    log('Contact fetched Succesfully');
    SharedpreFHotelId = prefs.getString('HotelID');
    log('Hotelid fetched Succesfully');
    SharedpreFHotelNAMe = prefs.getString('HotelName');
    log('HotelName fetched Succesfully');
  }

  removeSharedHotel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove hotel
    prefs.remove("UserTyp");
    log('uSerTyp-hotelSharedPrefRemovStatus:Success');
    //Remove contact
    prefs.remove("hotelContact");
    log('HotELcontact-hotelSharedPrefRemovStatus:Success');
    prefs.remove("HotelName");
    log('HotelName-hotelSharedPrefRemovStatus:Success');
  }
// upload data to firebase hotels table

  upload() async {
    log('upload started');

    hotelId = const Uuid().v4();

    CollectionReference orderRef =
        FirebaseFirestore.instance.collection('hotels');

    await orderRef.doc(username.text).set({
      'hotel_id': hotelId,
      'hotel_name': username.text,
      'details': description.text,
      'tax': tax.text,
      'username': buiSnsLogMOB.text,
      'password': password.text
    }).whenComplete(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserTyp', "hotel");
      log('usertyp-hote_SharedPref :Suceess');
      prefs.setString('HotelID', hotelId.toString());
      log('hotelId_SharedPref :Suceess');
      prefs.setString('HotelName', username.text.toString());
      log('HotelName_SharedPref :Suceess');
      Get.snackbar('✓', 'Successfully Uploaded');
      Get.offAll(home_screen());
    });

    //
    // );
  }
}
