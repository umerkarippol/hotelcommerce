import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderViewDEtails extends StatelessWidget {
  OrderViewDEtails({required this.order_id}) : super();
  String order_id;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> orderDetails = FirebaseFirestore.instance
        .collection('orderdetails')
        .where("Coustomer Id", isEqualTo: order_id)
        // .where("id", isEqualTo: doc_id)
        .snapshots();
    return Container(
      child: StreamBuilder(
          stream: orderDetails,
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
                  return Container(
                    height: 100,
                    width: 50,
                    color: Colors.amber,
                  );

                  //  Card(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15.0)),
                  //     color: Color.fromARGB(255, 243, 243, 243),
                  //     elevation: 10,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text("Quantity : " +
                  //             data.docs[index]['Quantity'].toString()),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         Text("Price : " +
                  //             data.docs[index]['Total Amount'].toString()),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         Text(
                  //           "Payment : " + data.docs[index]['Payment Mode'],
                  //           style: TextStyle(color: Colors.green),

                  //           // +data.docs[index]['Total Amount']
                  //           //               .toString()
                  //         )
                  //       ],
                  //     ));
                });
          }),
    );
  }
}
