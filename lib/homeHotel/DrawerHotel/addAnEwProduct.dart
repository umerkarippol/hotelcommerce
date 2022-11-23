import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/homeController.dart';

class AddAnEwProduct extends StatelessWidget {
  AddAnEwProduct({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A New  Product'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Form(
              key: homeController.PUpkey,
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 254, 253),
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Hotel Name: Orizeon',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        )),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Enter Product ID:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Obx(() => Visibility(
                                visible: homeController.AutogenButn.value,
                                child: ElevatedButton(
                                    onPressed: () {
                                      homeController.GneraterpoductId();
                                    },
                                    child: Text('AutoGenerate')))),
                          ],
                        ),

                        // TextField(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //   ),
                        // ),

                        Obx(
                          () => Flexible(
                            child: TextField(
                              enabled: homeController.textfeildEnable.value,
                              controller: homeController.UPLoadProctID,
                              decoration: InputDecoration(
                                  hintText: 'Product ID',
                                  hintStyle: TextStyle(
                                      fontSize: 17,
                                      color:
                                          Color.fromARGB(255, 181, 181, 181)),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 234, 240, 245),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                'Select a Category:',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Obx(
                                (() => DropdownButton(
                                      hint: Text(
                                        '' +
                                            homeController.Categorychoose.value,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      // value: controller.valuechoose.value,
                                      items: homeController.category
                                          .map((String value1) {
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
                                        homeController.Categorychoose.value =
                                            valuedis.toString();
                                        // log(valuechoose);
                                      },
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' Product Name:',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Flexible(
                          child: TextField(
                            controller: homeController.UPLoadProctName,
                            decoration: InputDecoration(
                                hintText: 'Enter Product Name',
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 181, 181, 181)),
                                filled: true,
                                fillColor: Color.fromARGB(255, 234, 240, 245),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Enter Product Description:',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextField(
                      minLines: 4,
                      maxLines: 6,
                      controller: homeController.UPLoadProctDEscription,
                      decoration: InputDecoration(
                          hintText: 'Product Description',
                          hintStyle: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 181, 181, 181)),
                          filled: true,
                          fillColor: Color.fromARGB(255, 234, 240, 245),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '    Price: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: homeController.UPLoadProctPrice,
                            decoration: InputDecoration(
                                hintText: '   ₹',
                                hintStyle: TextStyle(
                                    fontSize: 23,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                filled: true,
                                fillColor: Color.fromARGB(255, 234, 240, 245),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        Flexible(
                            child: SizedBox(
                          width: double.infinity,
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 254, 253),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ' UPLOAD IMAGE:',
                            style: TextStyle(fontSize: 20),
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text('SELECT IMAGE')),
                          Text(
                            'FILE NAME',
                            style: TextStyle(fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
