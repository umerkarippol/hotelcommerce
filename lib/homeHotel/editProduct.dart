import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EDitProduct extends StatelessWidget {
  EDitProduct({required this.eproduct_id, required this.eprodutImage});
  var size, height, width;
  String eproduct_id, eprodutImage;
  // TextEditingController productIdControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
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
            'Edit Product',
            style: TextStyle(fontSize: 30),
          )),
          Container(
              //color: Colors.black,
              height: height / 6,
              width: width / 2,
              child: Image.asset('assets/images/editproduct.png')),
          TextFormField(
            enabled: false,
            // controller: eproduct_id as TextEditingController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_reset),
                labelText: 'Product Id : ' + eproduct_id,
                hintStyle: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 181, 181, 181)),
                filled: true,
                fillColor: Color.fromARGB(255, 234, 240, 245),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey,
            child: Column(
              children: [
                Align(
                  child: Text(
                    'SELECT IMAGE',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height / 6,
                      width: width / 6,
                      child: Image.network(eprodutImage),
                    ),
                    Visibility(
                      visible: true,
                      replacement: Icon(
                        Icons.check_circle,
                        color: Color.fromARGB(255, 13, 117, 17),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                                height: height / 6,
                                width: width / 6,
                                child: Image.asset(
                                    'assets/images/changeImag.png')),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ))),
    );
  }
}
