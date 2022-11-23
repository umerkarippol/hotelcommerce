import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/cart/cart.dart';
import 'package:hotelservice/check_out/check_out.dart';
import 'package:hotelservice/controller/cartcontroller.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/model/cartmodel.dart';

class cartfinal extends StatefulWidget {
  cartfinal({Key? key}) : super(key: key);

  @override
  State<cartfinal> createState() => _cartfinalState();
}

class _cartfinalState extends State<cartfinal> {
  scannercontroller controllerof_scanner = Get.put(scannercontroller());
  late String table_no;
  String valuechoose = '1';

  List listitems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  int count = 1;
  CartViewModel controllerfind = Get.find();
  // scannercontroller controllers = Get.put(scannercontroller());
  CartViewModel controller = Get.put(CartViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Cart"),
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
          backgroundColor: Color.fromARGB(255, 13, 120, 213),
        ),
        body: GetBuilder<CartViewModel>(
            builder: (controller) => controller.cartProducts.isEmpty
                ? Center(
                    child: Text('Empty Cart..'),
                  )
                : Obx(() => ListView.builder(
                    itemCount: controller.cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartitems = controller.cartProducts[index];
                      log("total =" + cartitems.total.toString());

                      return Container(
                        width: 300,
                        height: 200,
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color.fromARGB(255, 236, 235, 235),
                          elevation: 10,
                          child: Wrap(
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  leading: Container(
                                    height: 200,
                                    width: 100,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: NetworkImage(cartitems.image
                                                // data.docs[index]['image']
                                                ),
                                            fit: BoxFit.cover)),
                                    // child: Image.network(data.docs[index]['image'])
                                  ),
                                  title: Text(cartitems.name,
                                      // data.docs[index]['item'],
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 79, 78, 77),
                                          fontSize: 35.0,
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dotted,
                                          fontWeight: FontWeight.bold)),
                                  // ignore: prefer_const_constructors
                                  subtitle: Wrap(
                                    children: [
                                      Text(
                                          'Total:  ' +
                                              cartitems.total.toString(),
                                          style: TextStyle(
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w300)),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (cartitems.qty > 1) {
                                                    controller.decrement(index);
                                                  } else {
                                                    Get.snackbar(
                                                      "Warning",
                                                      "Minimum Quantity 1 is Requred",
                                                      icon: const Icon(
                                                        Icons
                                                            .warning_amber_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      // isDismissible: true,
                                                      //                                         isDismissible: true,
                                                      //  dismissDirection:left,
                                                    );
                                                  }
                                                });
                                                // int quantity =
                                                //     documentSnapshot['qty'];
                                                // if (quantity > 1) {

                                                // } else {
                                                //   Get.snackbar("Error",
                                                //       "Minimum Quantity 1 is Requred");
                                                // }
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 186, 22, 22),
                                              )),
                                          Text(cartitems.qty.toString(),
                                              // documentSnapshot['qty'].toString(),
                                              style: TextStyle(
                                                  fontSize: 28.0,
                                                  fontWeight: FontWeight.w300)),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  controller.increment(index);
                                                });
                                              },
                                              icon: Icon(Icons.add,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 47, 94, 4)))
                                        ],
                                      )
                                    ],
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        print("index :" + index.toString());
                                        controller.remove(index);

                                        // log("click id==" + cartitems.product_id);
                                        // setState(() {
                                        // controller.cartProducts.remove(index);

                                        //   log("worked");
                                        // });
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ))

                                  //  Icon(Icons.cancel)
                                  //  Text(data.docs[index]['item']),
                                  )
                            ],
                          ),
                        ),
                      );
                    }))),
        bottomSheet: Obx(
          () => Container(
            height: 75,
            color: Color.fromARGB(255, 26, 75, 180),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'GRAND TOTAL:  ' + controller.total.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'muli',
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                        backgroundColor: Color.fromARGB(255, 179, 179, 179),
                        title: 'Please Enter Your Table No.',
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child: Obx(
                              (() => DropdownButton(
                                    hint: Text(
                                      '  TABLE: ' +
                                          controller.valuechoose.value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 12, 127, 185)),
                                    ),
                                    // value: controller.valuechoose.value,
                                    items: controllerof_scanner.Table.map(
                                        (String value1) {
                                      return DropdownMenuItem<String>(
                                        value: value1,
                                        child: Text(
                                          value1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (valuedis) {
                                      controller.valuechoose.value =
                                          valuedis.toString();
                                      log(valuechoose);
                                    },
                                  )),
                            ),
                          ),
                        ),

                        // DropdownButton(
                        //     value: valuechoose,
                        //     items: listitems.map((valueItem) {
                        //       return DropdownMenuItem(
                        //           value: valueItem, child: Text(valueItem));
                        //     }).toList(),
                        //     onChanged:  (  newvalue) {
                        //       setState(() {
                        //         valuechoose = newvalue;
                        //       });
                        //     })
                        //  TextField(
                        //   style: TextStyle(fontSize: 40),
                        //   keyboardType: TextInputType.number,
                        //   maxLength: 2,
                        //   controller: controller.tablenocontroller,
                        //   textAlign: TextAlign.center,
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(
                        //       Icons.table_restaurant_outlined,
                        //       size: 50,
                        //     ),
                        //     // labelText: 'Please Enter Your Table No.',
                        //     filled: true,
                        //     hoverColor: Colors.blue.shade100,
                        //     border: OutlineInputBorder(),
                        //   ),
                        // ),

                        textConfirm: 'OK',
                        confirmTextColor: Colors.black,
                        onConfirm: () {
                          controller.tax_calculate();
                          // controller.Listinsertion();
                          table_no = controller.valuechoose.value;

                          log('table number' + table_no);
                          Get.to(check_out(
                            table_no: table_no,
                          ));
                        },
                      );
                    },
                    child: Text(
                      'CHECK OUT',
                      style: TextStyle(
                          fontFamily: 'muli',
                          fontSize: 20,
                          color: Colors.amber),
                    ))
              ],
            ),
          ),
        ));
  }
}
