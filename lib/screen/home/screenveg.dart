import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/cart/cart.dart';
import 'package:hotelservice/screen/home/productdetails.dart';

import '../../cart/cartfinal.dart';
import '../../controller/scannercontrolller.dart';

class veg_ extends StatefulWidget {
  @override
  State<veg_> createState() => _veg_State();
}

scannercontroller hotelid = Get.put(scannercontroller());
late String doc_id = hotelid.ScannedQrcode;

class _veg_State extends State<veg_> {
  final Stream<QuerySnapshot> hotel = FirebaseFirestore.instance
      .collection('veg')
      .where("id", isEqualTo: doc_id)
      // .where("id", isEqualTo: doc_id)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Get.to(cartfinal());
                  },
                  icon: Icon(Icons.shopping_cart_checkout))
            ],
            title: const Text("Vegitarion"),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 70.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            elevation: 0.00,
            backgroundColor: Colors.greenAccent[400],
          ), //AppBar
          body: Container(
            child: StreamBuilder(
              stream: hotel,
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
                      backgroundColor: Colors.green,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 10,
                    ),
                  );
                }
                final data = snapshot.requireData;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 15,
                            mainAxisExtent: 320),
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Product_Details(
                          //             image: data.docs[index]['image'],
                          //           )),
                          // );
                          Get.to(Product_Details(
                            item_name: data.docs[index]['item'],
                            description: data.docs[index]['description'],
                            price: data.docs[index]['price'],
                            image: data.docs[index]['image'],
                            product_id: data.docs[index]['productid'],
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            width: MediaQuery.of(context).size.width,
                            // width: 164,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            data.docs[index]['image'])),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                    // image: DecorationImage(
                                    //     image: NetworkImage(
                                    //
                                    //
                                    //        data.docs[index]['image']))
                                  ),
                                  height: 240,
                                  width: 164,
                                  // child: Image.network(
                                  //   data.docs[index]['image'],
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                Text(
                                  data.docs[index]['item'],
                                  // style: TextStyle(
                                  //   fontSize: 16,

                                  // ),

                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(0, -5))
                                      ],
                                      color: Colors.transparent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.black,
                                      decorationThickness: 4,
                                      decorationStyle:
                                          TextDecorationStyle.dashed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                // Text(data.docs[index]['description']),
                                Text(
                                  "₹" + data.docs[index]['price'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });

                // ListView.builder(
                //     itemCount: data.size,
                //     itemBuilder: (context, index) {
                //       return
                //        Card(
                //           child: Container(
                //               width: 100,
                //               height: 100,
                //               child: Image.network(data.docs[index]['image']))
                //           // child: Text(data.docs[index]['item']),

                //           );

                //       // Image.network(data.docs[index]['image']);
                //     });
              },
            ),
          )),
    );
  }
}
