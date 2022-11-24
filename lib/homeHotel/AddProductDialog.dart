import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddProductDialog extends StatelessWidget {
  AddProductDialog({Key? key}) : super(key: key);

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: Color.fromARGB(255, 0, 0, 0),
                iconSize: 40,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.clear_rounded),
              )),
          Align(
              child: Text(
            'Add Product',
            style: TextStyle(fontSize: 30),
          )),
          Container(
              //color: Colors.black,
              height: height / 6,
              width: width / 2,
              child: Image.asset('assets/images/addprocts.png'))
        ],
      )),
    );
  }
}
