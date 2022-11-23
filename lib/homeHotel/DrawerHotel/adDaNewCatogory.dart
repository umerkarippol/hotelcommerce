import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotelservice/controller/homeController.dart';
import 'package:hotelservice/controller/hotel_authContrlr.dart';

class AddAnEWcaTegory extends StatelessWidget {
  AddAnEWcaTegory({Key? key}) : super(key: key);
  HomeController hotelHOMEController = Get.put(HomeController());
  hotel_authController hotelAuthController = Get.put(hotel_authController());

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryDetails = FirebaseFirestore.instance
        .collection('category')
        .where("hotel_id",
            isEqualTo: hotelAuthController.SharedpreFHotelId.toString())
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A New Category'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 254, 253),
                  border: Border.all(
                      color: Color.fromARGB(255, 0, 0, 0), // Set border color
                      width: 1.0), // Set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)), // Set rounded corner radius
                  // boxShadow: [
                  //   BoxShadow(
                  //       blurRadius: 10,
                  //       color: Color.fromARGB(255, 207, 207, 207),
                  //       offset: Offset(1, 3))
                  // ] // Make rounded corner of border
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('QRID:' +
                          hotelAuthController.SharedpreFHotelId.toString()),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RichText(
                        text: TextSpan(
                            text: '    Hotel Name:',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                          TextSpan(
                              text: hotelAuthController.SharedpreFHotelNAMe
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 0, 0)))
                        ])),
                    // Text(
                    //   '    Hotel Name:' +
                    //       hotelAuthController.SharedpreFHotelNAMe.toString(),
                    //   style:
                    //       TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Enter New Category Name:'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: hotelHOMEController.categoryField,
                        decoration: InputDecoration(
                            hintText: 'Enter Your Category',
                            filled: true,
                            fillColor: Color.fromARGB(255, 234, 240, 245),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              ElevatedButton(
                  onPressed: () {
                    hotelHOMEController.uploadCatgry();
                  },
                  child: Text('Add Category')),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: StreamBuilder(
                    stream: categoryDetails,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return Text('Something Went Wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Color.fromARGB(255, 244, 220, 2),
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                          ),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Sorry \n Your Hotel Doesnt Added any category Yet. ',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w100),
                          ),
                        );
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                          itemCount: data.size,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            int i = index;
                            i = i + 1;

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(
                                            255, 0, 0, 0), // Set border color
                                        width: 1.0),
                                    color: Color.fromARGB(255, 255, 254, 253),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '     ' + i.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        data.docs[index]['category_item'],
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 17, 17, 17),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          hotelHOMEController.DeleteNewCategory(
                                              data.docs[index].id);
                                        },
                                        icon:
                                            Icon(Icons.delete_forever_rounded),
                                        color: Colors.red,
                                      )
                                    ],
                                  )),
                            );
                          });
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
