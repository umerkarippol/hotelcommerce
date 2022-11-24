import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotelservice/controller/hotel_authContrlr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class hotel_DeTaiLS extends StatelessWidget {
  hotel_DeTaiLS({Key? key}) : super(key: key);
  hotel_authController hotel_contrl = Get.put(hotel_authController());
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                  key: hotel_contrl.formKey_signIn,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 50,
                      // ),
                      Container(
                        // height: MediaQuery.of(context).size.height * 04,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            Text(
                              'HOTEL SIGN IN',
                              style: TextStyle(
                                  // textBaseline:,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                            Divider(
                              height: 2,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              controller: hotel_contrl.username,
                              decoration: InputDecoration(
                                labelText: 'Hotel Name',
                                hintText: 'Enter Hotel Name',
                                prefixIcon: Icon(Icons.deck_sharp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return value = ('* Hotel Name is  Required ');
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              minLines: 3,
                              maxLines: 4,
                              controller: hotel_contrl.description,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                hintText: 'Hotel Description',
                                prefixIcon: Icon(Icons.description_sharp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return value =
                                      ('* Hotel Description is  Required ');
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              controller: hotel_contrl.tax,
                              decoration: InputDecoration(
                                labelText: 'Tax %',
                                hintText: '',
                                prefixIcon: Icon(Icons.percent_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return value = ('*Enter Your Tax \neg:18%');
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 229, 229, 229),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Provide Your Login credential',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      enabled: false,
                                      // controller: hotel_contrl.buiSnsLogMOB.text,
                                      decoration: InputDecoration(
                                        // hintText: "Username:" +
                                        // hotel_contrl.SharedpreFcoNtactHotel
                                        //     .toString(),
                                        prefixIcon: Icon(Icons.person_outlined),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      // validator: (value) {
                                      //   hotel_contrl.conTainsData_Check(value);
                                      // },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => TextFormField(
                                          maxLength: 12,
                                          controller: hotel_contrl.password,
                                          // obscureText: true,
                                          decoration: InputDecoration(
                                              errorText: hotel_contrl
                                                  .errorTextpass.value,
                                              hintText: 'Enter Your Password',
                                              prefixIcon: Icon(
                                                Icons.lock_outline,
                                                color: Color.fromARGB(
                                                    255, 99, 165, 24),
                                              ),

                                              // prefixIconColor: Color.fromARGB(255, 38, 99, 40),
                                              filled: true,
                                              fillColor: Color.fromARGB(
                                                  255, 209, 211, 212),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              )),
                                          validator: (value) {
                                            hotel_contrl.Password_checkSignIn(
                                                value);
                                          }),
                                    ),
                                    TextFormField(
                                        maxLength: 12,
                                        controller:
                                            hotel_contrl.confirmpassword,
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                            errorText: hotel_contrl
                                                .errorTextpass.value,
                                            hintText: 'Renter Your Password',
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: Color.fromARGB(
                                                  255, 99, 165, 24),
                                            ),

                                            // prefixIconColor: Color.fromARGB(255, 38, 99, 40),
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                255, 209, 211, 212),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            )),
                                        validator: (value2) {
                                          hotel_contrl.Password_checkSignIn(
                                              value2);
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // if (hotel_contrl.formKey_signIn.currentState!
                                //     .validate()) {
                                //   log("kkkkkkkkkkkkkk");
                                // }
                                hotel_contrl.submit_signIn();
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                side: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 1.5),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _auth.signOut();

                            //       SharedPreferences prefs =
                            //           await SharedPreferences.getInstance();

                            //       prefs.remove("UserTyp");
                            //       log('hotelsharedpreferenceremovedsuccessfully');
                            //       prefs.remove("hotelContact");
                            //       log('hotelsharedpreferenceremovedsuccessfully[Mobile]');
                            //     },
                            //     child: Text('SharedPrefREMVHotlDEmo'))
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
