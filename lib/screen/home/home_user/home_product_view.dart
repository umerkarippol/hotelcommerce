import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';
import 'package:hotelservice/screen/home/productdetails.dart';
import 'package:hotelservice/screen/home/screen_nonveg.dart';

class ViewProducts extends StatefulWidget {
  String tabitem;

  ViewProducts({required this.tabitem});

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

scannercontroller hotelidcontroller1 = Get.put(scannercontroller());
String doc_id = hotelidcontroller1.ScannedQrcode;

class _ViewProductsState extends State<ViewProducts> {
  // final Stream<QuerySnapshot> _prodcutsStream = FirebaseFirestore.instance
  //     .collection('products')
  //     .where('maincateg', isEqualTo: tabitem)
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    print("itemmm======" + widget.tabitem);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('category_item', isEqualTo: widget.tabitem)
          .where('hotel_id', isEqualTo: 10001)
          .snapshots(),
      // _prodcutsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text(
            'This category \n\n has no items yet !',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 26,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acme',
                letterSpacing: 1.5),
          ));
        }
        final data = snapshot.requireData;
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 15,
                mainAxisExtent: 320),
            itemCount: data.size,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(Product_Details(
                      item_name: data.docs[index]['item'],
                      description: data.docs[index]['description'],
                      price: data.docs[index]['price'].toDouble(),
                      image: data.docs[index]['image'],
                      product_id: data.docs[index]['product_id']));
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
                                image: NetworkImage(
                                  data.docs[index]['image'],
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            // image: DecorationImage(
                            //     image: NetworkImage(
                            //         data.docs[index]['image']))
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
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 4,
                              decorationStyle: TextDecorationStyle.dashed,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        // Text(data.docs[index]['description']),
                        Text(
                          "₹" + data.docs[index]['price'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
