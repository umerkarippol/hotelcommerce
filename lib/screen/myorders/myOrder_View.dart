import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hotelservice/screen/myorders/oRderDetailsview.dart';

class mYoRderview extends StatelessWidget {
  mYoRderview({required this.order, required this.orderid});

  // bool _hasBeenPressed = false;
  final dynamic order, orderid;

  var productName;

  var proimage;

  var proprice;

  var proid;

  @override
  Widget build(BuildContext context) {
    log(order['Date'].toString());
    log("order id = " + orderid.toString());
    Timestamp t = order['Date'];
    DateTime d = t.toDate();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(maxHeight: 90),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.toString(),
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'muli',
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w700),
                      ),
                      Text('Grand Total : ' + order['Grand Total'].toString()),

                      RichText(
                          text: TextSpan(
                              text: 'Payment Mode : ',
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                                text: order['Payment Mode'],
                                style: TextStyle(color: Colors.green))
                          ])),
                      // Text(
                      //   'Payment Mode : ' + order['Payment Mode'],
                      //   style: TextStyle(color: Colors.green),
                      // ),
                      SizedBox(height: 20)
                    ],
                  ),
                )
              ],
            ),
          ),
          subtitle: Text(
            'Order Id : ' + orderid,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orderdetails')
                    .where("Order Id", isEqualTo: orderid)
                    // .where("id", isEqualTo: doc_id)
                    .snapshots(),
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
                  log("length ===" + data.size.toString());
                  return Container(
                    height: 200,
                    color: Color.fromARGB(255, 243, 243, 243),
                    child: ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                data.docs[index]['image']),
                                            fit: BoxFit.cover)),
                                    // child: Image.network(data.docs[index]['image'])

                                    child: Text(
                                      'Nos - ' +
                                          data.docs[index]['Quantity']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color:
                                            Color.fromARGB(255, 210, 200, 200),
                                        backgroundColor:
                                            Color.fromARGB(255, 245, 31, 31),
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Quantity  : ' +
                                        data.docs[index]['Quantity'].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text('Price  : ' +
                                      data.docs[index]['Total Amount']
                                          .toString()),
                                ],
                              ));
                        }),
                  );
                  // OrderViewDEtails(order_id: orderid)
                })
          ],
        ),
      ),
    );
  }
}
