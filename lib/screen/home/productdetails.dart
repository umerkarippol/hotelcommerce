import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hotelservice/cart/cart.dart';
import 'package:hotelservice/cart/cartfinal.dart';
import 'package:hotelservice/controller/cartcontroller.dart';

import 'package:hotelservice/model/cartmodel.dart';
import 'package:hotelservice/screen/home/home_user/tab_bar.dart';
import 'package:hotelservice/screen/home/screen_home.dart';

class Product_Details extends StatelessWidget {
  CartViewModel controller = Get.put(CartViewModel());
  // const Product_Details({Key? key}) : super(key: key);
  late String image, item_name, description;
  late int product_id;
  double? total, price;
  CartViewModel controllercheck = Get.put(CartViewModel());

  CollectionReference AddCart = FirebaseFirestore.instance.collection('cart');

  Product_Details(
      {required this.item_name,
      required this.description,
      required this.price,
      required this.image,
      required this.product_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(""),
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              item_name,
                              style: TextStyle(fontSize: 60),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 33,
                          ),
                          Text(
                            description,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   'PRICE',
                //   style: TextStyle(
                //       fontSize: 30, color: Color.fromARGB(255, 27, 143, 16)),
                // ),
                Text("₹" + price.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.black))
              ],
            ),
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Alert',
                      titleStyle: TextStyle(fontSize: 25),
                      middleText: item_name + '\n is added to Cart',
                      middleTextStyle: TextStyle(fontSize: 20),
                      backgroundColor: Colors.grey,
                      radius: 20,
                      textCancel: 'Cancel',
                      cancelTextColor: Color.fromARGB(255, 125, 31, 24),
                      textConfirm: 'Confirm',
                      confirmTextColor: Colors.white,
                      onConfirm: ()

                          // async

                          {
                        CartMOdel modelds = CartMOdel(
                            name: item_name,
                            image: image,
                            price: price,
                            qty: 1,
                            product_id: product_id,
                            total: price);

                        // CartMOdel modelds = CartMOdel(
                        //     image: image,
                        //     total: price,
                        //     price: price,
                        //     qty: 1,
                        //     name: item_name,
                        //     product_id: product_id);
                        //controller.cartProducts.add(modelds);
                        controller.addProduct(modelds);
                        // Cart.add(modelds);

                        // await AddCart.add({
                        //   'item': item_name,
                        //   'price': price,
                        //   'image': image,
                        //   'qty': 1,
                        //   'total': 0
                        // }).then((value) => print('User added'));

                        Get.bottomSheet(Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(tabbartest());
                                },
                                child: Text(
                                  'BACK TO HOME',
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(10)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.red)))),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(cartfinal());
                                },
                                child: Text('GO TO CART',
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            side: BorderSide(
                                                color: Colors.red)))),
                              )
                            ],
                          ),
                        ));
                        // Get.defaultDialog(
                        //     title: 'Alert',
                        //     titleStyle: TextStyle(fontSize: 25),
                        //     middleText: 'Go to cart',
                        //     middleTextStyle: TextStyle(fontSize: 20),
                        //     backgroundColor: Colors.grey,
                        //     radius: 20,

                        //     actions: [
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           Get.to(screen_home());
                        //         },
                        //         child: Text('Back to Home'),
                        //       ),
                        //       ElevatedButton(
                        //           onPressed: () {
                        //             Get.to(cart());
                        //           },
                        //           child: Text('Goto Cart'))
                        //     ]);
                      },
                      buttonColor: Color.fromARGB(255, 17, 119, 21),
                      barrierDismissible: false);
                },
                icon: Icon(
                  Icons.shopping_cart_checkout_sharp,
                  size: 60,
                  color: Colors.amber,
                ))
          ],
        ),
        height: 100,
        color: Colors.white,
      ),
    );
  }
}
