import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hotelservice/cart/cart.dart';
import 'package:hotelservice/check_out/check_out.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/model/cartmodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

import '../screen/home/dynamic/tab_bar.dart';

class CartViewModel extends GetxController {
  // @override
  // void onReady() {
  //   Listinsertion();
  //   // TODO: implement onReady
  //   super.onReady();
  // }

  scannercontroller controller = Get.put(scannercontroller());
  // RxList cartProducts = [].obs;
  var cartProducts = [].obs;
  TextEditingController tablenocontroller = TextEditingController();

  Rx<double> total = 0.0.obs;
  double tax_total = 100.0;
  late Razorpay razorpay;

  String abcdd = "10";
////
//DROP

  // Listinsertion() {
  //   int n = 100;
  //   //List Table = [];

  //   int tablelegth = controller.total_table_no;
  //   for (int i = 0; i <= n; i++) {
  //     if (i <= tablelegth) {
  //       String i1 = i.toString();
  //       Table.add(i1);
  //       log(i.toString());
  //     } else {
  //       log('compltd');
  //     }
  //   }
  // }

  // List<String> Table = [];

  RxString valuechoose = '1'.obs;
  List<String> tablenumberarray = ['1', '2'];
  @override
  void onInit() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Razorpay _razorpay = Razorpay();
    _razorpay.clear;

    log('razorpaydisposed');
    super.dispose();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    log('success');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    log(response.toString());
    log('failed');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  open_razor_pay() {
    var options = {
      'key': 'rzp_test_VsMPAOYw5nXeYv',
      "amount": tax_total * 100,
      'description': 'Fine T-Shirt',
      'name': controller.namefromfire,
      'prefill': {'contact': '123456969', 'email': 'akshchrop@gmail.com'}
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  // double? tax_total;
  // double tax_total = 0.0;

  late double tax;
  String? table;
  late String orderId, orderdatails_id;

  //=======+++++
  String _orderType = '';
  String get orderType => _orderType;
  void setOrderType(String type) {
    _orderType = type;
    update();
    log(orderType);
  }

  On_confirmOrder() {
    if (orderType == 'Cash') {
      log('paymentmode=========by cash');
      upload();
    } else if (orderType == 'Online') {
      open_razor_pay();
      log('paymentmode=========online');
    }
  }

  //=======+++++

//=============
//  var report = Report().obs;
  // RxInt selectedPeriodd = 0.obs;

//=============

  // Product_Check(int product_id,index) {
  //   for (int i = 0; i <= cartProducts.length;i++) {

  //   }
  // }
  tax_calculate() {
    log(controller.tax.toString());

    tax = total.value * controller.tax / 100;
    log(tax.toString());

    tax_total = total.value + tax;

    log("tax_total:" + tax_total.toString());

    log("Total++++" + total.toString());
  }

  addProduct(CartMOdel model) {
    //cartProducts.add(model);

    var contain =
        cartProducts.where((element) => element.product_id == model.product_id);
    if (contain.isNotEmpty) {
      log("inside match");

      Get.snackbar('Alert', 'Item is Already in Your Cart',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(
            Icons.warning_amber_sharp,
            size: 35,
          ));
      // Get.defaultDialog(
      //     title: 'Alert',
      //     content: Text(
      //         textAlign: TextAlign.center,
      //         'The Item Is Already  In Your \nCart'));
      log('already the item is existing in cart');
    } else {
      cartProducts.add(model);
      log("Addedd");
    }
    //value not exists
    total = total + double.parse(model.price.toString());

    log("total ===" + total.toString());
  }

  remove(int index) {
    total = total - cartProducts[index].total;
    cartProducts.removeAt(index);
    log(total.toString());
    //total = total - total.value;
    print("product_id :" + index.toString());

    print("cartProducts lenth :" + cartProducts.length.toString());
  }

  increment(int index) async {
    cartProducts[index].qty++;
    cartProducts[index].total = cartProducts[index].price;
    cartProducts[index].total =
        cartProducts[index].price * cartProducts[index].qty;

    //total = total + 20;

    total = (total + cartProducts[index].price);
    log('total :' + total.toString());
    log('cartproduct total' + cartProducts[index].total.toString());
  }

  decrement(int index) async {
    log('decrement');
    cartProducts[index].qty--;

    cartProducts[index].total =
        cartProducts[index].price * cartProducts[index].qty;
    total = (total - cartProducts[index].price);

    log('total :' + total.toString());
    log('cartproduct total' + cartProducts[index].total.toString());

    log('Grand total' + total.toString());
    // log(total.toString());
    // return total;
  }

  upload() async {
    log('upload started');
    log('upload started' + tablenocontroller.text);
    orderId = const Uuid().v4();

    CollectionReference orderRef =
        FirebaseFirestore.instance.collection('orders');

    await orderRef.doc(orderId).set({
      'Order Id': orderId,
      'Coustomer Id': controller.uidd,
      'Grand Total': total.toDouble(),
      'Table No': valuechoose.value,
      'Payment Mode': orderType,
      'Date': DateTime.now()
    }).whenComplete(
      () async {
        cartProducts.forEach((element) async {
          log(element.total.toString());
          log(element.product_id.toString());
          orderdatails_id = const Uuid().v4();
          CollectionReference orderDetailsRef =
              FirebaseFirestore.instance.collection('orderdetails');
          await orderDetailsRef.doc(orderdatails_id).set({
            'Product name': element.name,
            'Date': DateTime.now(),
            'Order Id': orderId,
            'image': element.image,
            'Coustomer Id': controller.uidd,
            'Product Id': element.product_id,
            'Quantity': element.qty,
            'Total Amount': element.price * element.qty
          });
        });
      },
    ).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Order Compleated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 29, 84, 3),
          textColor: Color.fromARGB(255, 254, 255, 253),
          fontSize: 16.0);
      Get.offAll(tabbartest());
      cartProducts.clear();
      total.value = 0;
    });
    log('upload compleated');
  }

  // void selectedPeriod(String selectedPeriod) {
  //   log("messageinside" + selectedPeriod);

  //   if (selectedPeriod.contains("abcd")) {}
  // report.update((report) {
  //   report.selectedPeriod = selectedPeriod;
  // });
  // selectedPeriodd = selectedPeriod as RxInt;
  // }

  // String get selectedPeriod => report.value.selectedPeriod;
///////////////////////////////////////////////////////////////////
  //DROP DOWN

}
