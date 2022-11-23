import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/screen/myorders/myOrder_View.dart';

class mYOrders_ extends StatefulWidget {
  const mYOrders_({Key? key}) : super(key: key);

  @override
  State<mYOrders_> createState() => _mYOrders_State();
}

scannercontroller hotelid = Get.put(scannercontroller());
late String doc_id = hotelid.uidd;

class _mYOrders_State extends State<mYOrders_> {
  final Stream<QuerySnapshot> hotel = FirebaseFirestore.instance
      .collection('orders')
      .where("Coustomer Id", isEqualTo: doc_id)
      // .orderBy('Grand Toatal', descending: true)
      // .orderBy('Date')
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
        ),
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

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Sorry \n You Have No Active Orders ! ',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                    ),
                  );
                }
                final data = snapshot.requireData;
                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      var order = snapshot.data?.docs[index];
                      var orderid = order!.id;
                      return mYoRderview(
                          order: snapshot.data!.docs[index], orderid: orderid);
                    });
              }),
        ));
  }
}
