import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/widgets/radiobutton.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

import '../controller/cartcontroller.dart';
import '../controller/scannercontrolller.dart';

class check_out extends StatelessWidget {
  CartViewModel controllerfind = Get.find();
  String table_no;

  late String orderId;
  CartViewModel controller = Get.put(CartViewModel());
  scannercontroller Scan_controller = Get.put(scannercontroller());

  check_out({required this.table_no});

  Razorpay razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Payment',
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[200],
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
        child: Column(children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Amount',
                        style: TextStyle(
                            fontFamily: "muli",
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      Text(
                        controller.total.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GST',
                        style: TextStyle(
                            fontFamily: "muli",
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      // Text(controller.tax.toString())
                      Text(
                        controller.tax.toString(),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total',
                        style: TextStyle(fontSize: 20, fontFamily: "muli"),
                      ),
                      Text(
                        controller.tax_total.toString(),
                        style:
                            const TextStyle(fontSize: 20, fontFamily: "muli"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Table Number',
                    style: TextStyle(fontSize: 20, fontFamily: "muli"),
                  ),
                  Text(
                    table_no,
                    style: const TextStyle(fontSize: 20, fontFamily: "muli"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 135, 188),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              OrderButton(value: 'Cash', title: 'Pay By Cash'),
              OrderButton(value: 'Online', title: 'Pay Now'),
              SizedBox(
                height: 80,
              ),
              // Obx(() => Text(controller.orderType))
            ],
          ))
        ]),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Center(
            child: ElevatedButton(
          onPressed: () async {
            // controller.open_razor_pay();
            controller.On_confirmOrder();
            // controllerfind.table = table_no;

            // controller.upload();

            // ====================
            // orderId = const Uuid().v4();
            // log('upload initiated');

            // CollectionReference orderRef =
            //     FirebaseFirestore.instance.collection('orders');

            // await orderRef.doc(orderId).set({
            //   'Order Id': orderId,
            //   'Coustomer Id': Scan_controller.uidd,
            //   'Grand Total': controller.total.toDouble(),
            //   'Table No': table_no,
            //   'Date': DateTime.now()
            // }).whenComplete(() async {
            //   CollectionReference orderDetailsRef =
            //       FirebaseFirestore.instance.collection('orderdetails');

            //       for (var item in context.read<>().) { orderdetailsid =const Uuid().v4();

            // });

            // log('uploaded successfully');
          },
          child:

              // Text('${(controller.orderType == 'Pay_cash')}"pay"'),

              Text('PAY  ₹' + controller.tax_total.toString(),
                  style: TextStyle(fontSize: 20)),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 163, 129, 5)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.black)))),
        )),
      ),
    );
  }
}
