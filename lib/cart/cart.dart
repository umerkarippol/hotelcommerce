import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:hotelservice/screen/home/screen_nonveg.dart';
import 'package:hotelservice/screen/home/screenveg.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('cart');

  Future<void> _deleteProduct(String productId) async {
    await cart.doc(productId).delete();
    Get.snackbar('Deleted', 'You have successfully deleted a product');
  }

  Future<void> _increaseProduct(String productId, qty) async {
    qty++;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(productId)
        .update({'qty': qty});
  }

  Future<void> _decreaseProduct(productId, qty) async {
    qty--;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(productId)
        .update({'qty': qty});
  }

  Future<void> _total(String productId, int qty, int price) async {
    double total = 0;
    // amount += double.parse(row['quantity']) * double.parse(row['price']);

    total = total + (price * qty);
    // int total += qty* price;

    FirebaseFirestore.instance
        .collection('cart')
        .doc(productId)
        .update({'total': total});
  }

  @override
  Widget build(BuildContext context) {
    log("second reload");

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
        backgroundColor: Colors.greenAccent[400],
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: cart.snapshots(),
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
          // final data = snapshot.requireData;
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              //  data.size,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                return

                    //  Text(data.docs[index]['item']);

                    Container(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(documentSnapshot['image']
                                              // data.docs[index]['image']
                                              ),
                                      fit: BoxFit.cover)),
                              // child: Image.network(data.docs[index]['image'])
                            ),
                            title: Text(documentSnapshot['item'],
                                // data.docs[index]['item'],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 79, 78, 77),
                                    fontSize: 35.0,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.dotted,
                                    fontWeight: FontWeight.bold)),
                            // ignore: prefer_const_constructors
                            subtitle: Wrap(
                              children: [
                                Text(
                                    "Total:  " +
                                        documentSnapshot['total'].toString(),
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w300)),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _total(
                                              documentSnapshot.id,
                                              documentSnapshot['qty'],
                                              documentSnapshot['price']);

                                          int quantity =
                                              documentSnapshot['qty'];
                                          if (quantity > 1) {
                                            _decreaseProduct(
                                                documentSnapshot.id,
                                                documentSnapshot['qty']);
                                          } else {
                                            Get.snackbar("Error",
                                                "Minimum Quantity 1 is Requred");
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 30,
                                          color:
                                              Color.fromARGB(255, 186, 22, 22),
                                        )),
                                    Text(documentSnapshot['qty'].toString(),
                                        // documentSnapshot['qty'].toString(),
                                        style: TextStyle(
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.w300)),
                                    IconButton(
                                        onPressed: () {
                                          _increaseProduct(documentSnapshot.id,
                                              documentSnapshot['qty']);
                                          _total(
                                              documentSnapshot.id,
                                              documentSnapshot['qty'],
                                              documentSnapshot['price']);
                                        },
                                        icon: Icon(Icons.add,
                                            size: 30,
                                            color:
                                                Color.fromARGB(255, 47, 94, 4)))
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  _deleteProduct(documentSnapshot.id);

                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc()
                                      .delete();
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
              });
        },
      )),
      bottomSheet: Container(
        color: Color.fromARGB(255, 216, 195, 4),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text('Grand Total:'), Text('Checkout')],
        ),
      ),
    );
  }
}
