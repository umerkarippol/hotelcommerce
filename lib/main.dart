import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hotelservice/controller/cartcontroller.dart';
import 'package:hotelservice/controller/otpcontroller.dart';

import 'package:hotelservice/screen/QR_Screen.dart';

import 'package:hotelservice/screen/auth/auth_phone.dart';
import 'package:hotelservice/homeHotel/homescreen.dart';
import 'package:hotelservice/screen/auth/hotel_DeTaiLS.dart';
import 'package:hotelservice/screen/auth/hotel_registr.dart';
import 'package:hotelservice/screen/home/dynamic/tab_bar.dart';
import 'package:hotelservice/screen/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final otpcontrollerr = Get.put(otpcontroller());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(

      //   primarySwatch: Colors.blue,
      // ),
      home:

          //  home_screen(),

          //  hotel_registr()
          //  auth_phone()

          // Check_out()
          // tabbartest()
          //
          // screen_home()
          // HomePage1()
          InitializerWidget(),
    );
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:hotelservice/sample/homesreen.dart';
// import 'package:hotelservice/sample/loginscreen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: InitializerWidget());
//   }
// }

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  CartViewModel controller = Get.put(CartViewModel());
  late FirebaseAuth auth;

  User? _user;
  String? userTyp;
  String? coNtactHotel;
  String? coNtactUser;
  bool isLoading = true;
  getStringValuesSF() async {
    log('inside the sharedpref');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    userTyp = prefs.getString('UserTyp');
    coNtactHotel = prefs.getString('hotelContact');
    coNtactUser = prefs.getString('UsrContact');
    log(userTyp.toString());
    log(coNtactHotel.toString());
    if (userTyp == 'user') {
      Get.to(Qr_screen());
    } else if (userTyp == 'hotel') {
      Get.to(home_screen());
    }

    log(userTyp.toString());
    log(coNtactHotel.toString());

    // return log(
    //     "+++++++++++++++++++" + stringValue.toString() + "+++++++++++++++++++");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    auth = FirebaseAuth.instance;
    getStringValuesSF();

    _user = auth.currentUser;

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : auth_phone();
    // : _user == null
    //     ? auth_phone()
    //     // : hotel_DeTaiLS();
    //     : Qr_screen();
  }
}
