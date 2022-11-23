import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/cart/cart.dart';
import 'package:hotelservice/screen/home/productdetails.dart';

import '../../cart/cartfinal.dart';
import '../../controller/scannercontrolller.dart';

class MyOrders extends StatefulWidget {
  @override
  State<MyOrders> createState() => _veg_State();
}

scannercontroller hotelid = Get.put(scannercontroller());
late String doc_id = hotelid.uidd;

class _veg_State extends State<MyOrders> {
  final Stream<QuerySnapshot> hotel = FirebaseFirestore.instance
      .collection('orderdetails')
      .where("Coustomer Id", isEqualTo: doc_id)
      // .where("id", isEqualTo: doc_id)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("My Orders"),
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
          backgroundColor: Color.fromARGB(255, 0, 138, 230),
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
                      backgroundColor: Color.fromARGB(255, 244, 220, 2),
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 5,
                    ),
                  );
                }
                final data = snapshot.requireData;
                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          color: Color.fromARGB(255, 243, 243, 243),
                          elevation: 10,
                          child: ExpansionTile(
                              leading: Icon(Icons.blur_on_rounded),
                              controlAffinity: ListTileControlAffinity.trailing,
                              childrenPadding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.end,
                              maintainState: true,
                              title: Text(
                                data.docs[index]['Product name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 30),
                              ),
                              trailing: Text(
                                "Date &Time : " +
                                    data.docs[index]['Date']
                                        .toDate()
                                        .toString(),
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Quantity : " +
                                        data.docs[index]['Quantity']
                                            .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Price : " +
                                        data.docs[index]['Total Amount']
                                            .toString()),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Payment : " +
                                          data.docs[index]['Payment Mode'],
                                      style: TextStyle(color: Colors.green),

                                      // +data.docs[index]['Total Amount']
                                      //               .toString()
                                    )
                                  ],
                                )
                              ]));
                    });
              }),
        ));
  }
}
