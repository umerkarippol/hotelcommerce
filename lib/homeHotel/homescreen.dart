import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hotelservice/widgets/appdrawer.dart';
import 'package:hotelservice/widgets/appdrawerHotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_screen extends StatelessWidget {
  home_screen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: drawerHotel(),
        body: SafeArea(
            child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: ElevatedButton(
              onPressed: () async {
                await _auth.signOut();

                SharedPreferences prefs = await SharedPreferences.getInstance();

                prefs.remove("UserTyp");
                log('hotelsharedpreferenceremovedsuccessfully');
                prefs.remove("hotelContact");
                log('hotelsharedpreferenceremovedsuccessfully[Mobile]');
              },
              child: Text('LogOut\n&\nemoveallData')),
        )));
  }
}
