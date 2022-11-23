// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:hotelservice/controller/hotel_authContrlr.dart';
// import 'package:hotelservice/controller/scannercontrolller.dart';
// import 'package:hotelservice/screen/auth/hotel_DeTaiLS.dart';

// class hotel_registr extends StatelessWidget {
//   hotel_registr({Key? key}) : super(key: key);

//   hotel_authController hotel_contrl = Get.put(hotel_authController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: SingleChildScrollView(
//               child: Form(
//                   key: hotel_contrl.formKey_signUp,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // SizedBox(
//                       //   height: 50,
//                       // ),
//                       Container(
//                         // height: MediaQuery.of(context).size.height * 04,
//                         decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 240, 240, 236),
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: RichText(
//                                 text: TextSpan(
//                                     text: 'Hello',
//                                     style: TextStyle(
//                                         fontSize: 30, color: Colors.black),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                           text: '\nThere',
//                                           style: TextStyle(
//                                               fontSize: 65,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w800)),
//                                       TextSpan(
//                                           text: '.',
//                                           style: TextStyle(
//                                               fontSize: 85,
//                                               color: Color.fromARGB(
//                                                   255, 1, 99, 137),
//                                               fontWeight: FontWeight.w800))
//                                     ]),
//                               ),
//                             ),
//                             Divider(
//                               height: 2,
//                               color: Colors.black,
//                             ),
//                             Text(
//                               'HOTEL REGISTER',
//                               style: TextStyle(
//                                   // textBaseline:,
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                             Divider(
//                               height: 2,
//                               color: Colors.black,
//                             ),
//                             SizedBox(
//                               height: 50,
//                             ),
//                             // Obx(() => TextFormField(
//                             //       controller: hotel_contrl.gmail,
//                             //       decoration: InputDecoration(
//                             //         errorText:
//                             //             hotel_contrl.errorTextgmail.value,
//                             //         hintText: 'Enter Your Gmail',
//                             //         prefixIcon:
//                             //             Icon(Icons.mail_outline_rounded),
//                             //         border: OutlineInputBorder(
//                             //           borderRadius: BorderRadius.circular(20),
//                             //         ),
//                             //       ),
//                             //       validator: (value1) {
//                             //         hotel_contrl.gmail_Check(value1);
//                             //       },
//                             //     )),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Obx(
//                               () => TextFormField(
//                                   maxLength: 12,
//                                   maxLengthEnforcement:
//                                       MaxLengthEnforcement.none,
//                                   controller: hotel_contrl.password,
//                                   // obscureText: true,
//                                   decoration: InputDecoration(
//                                       errorText:
//                                           hotel_contrl.errorTextpass.value,
//                                       hintText: 'Enter Your Password',
//                                       prefixIcon: Icon(
//                                         Icons.lock_outline,
//                                         color: Color.fromARGB(255, 99, 165, 24),
//                                       ),

//                                       // prefixIconColor: Color.fromARGB(255, 38, 99, 40),
//                                       filled: true,
//                                       fillColor:
//                                           Color.fromARGB(255, 209, 211, 212),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide.none,
//                                       )),
//                                   validator: (value2) {
//                                     hotel_contrl.Password_checkSignUP(value2);
//                                   }),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Obx(
//                               () => TextFormField(
//                                 maxLength: 12,
//                                 controller: hotel_contrl.confirmpassword,
//                                 // obscureText: true,
//                                 decoration: InputDecoration(
//                                     errorText: hotel_contrl.errorTextpass.value,
//                                     hintText: 'Confirm Your Password',
//                                     prefixIcon: Icon(
//                                       Icons.lock_outline,
//                                       color: Color.fromARGB(255, 99, 165, 24),
//                                     ),

//                                     // prefixIconColor: Color.fromARGB(255, 38, 99, 40),
//                                     filled: true,
//                                     fillColor:
//                                         Color.fromARGB(255, 209, 211, 212),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide.none,
//                                     )),
//                                 validator: (value3) {
//                                   // hotel_contrl.Password_check(value3);

//                                   //   RegExp regex = RegExp(
//                                   //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//                                   //   var passNonNullValue = value ?? "";
//                                   //   if (value!.isEmpty) {
//                                   //     return 'Enter a valid password!';
//                                   //   } else if (value.length < 8) {
//                                   //     return ("Password Must be more than 8 characters");
//                                   //   } else if (!regex.hasMatch(passNonNullValue)) {
//                                   //     return ("Password should contain upper,lower,digit and Special character ");
//                                   //   } else if (password.text == confirmpassword.text) {
//                                   //     return ('Password Does not match!');
//                                   //   }
//                                   //   return null;
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 hotel_contrl.submit_signUp();
//                               },
//                               child: Text(
//                                 'Register',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.black,
//                                 onPrimary: Colors.white,
//                                 side: BorderSide(
//                                     color: Color.fromARGB(255, 255, 255, 255),
//                                     width: 1.5),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               children: [
//                                 Text('  Already havde an account?'),
//                                 TextButton(
//                                     onPressed: () {
//                                       Get.to(hotel_DeTaiLS());
//                                     },
//                                     child: Text('Sign In'))
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
