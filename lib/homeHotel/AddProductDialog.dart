import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/home_DrawerController.dart';
import 'package:hotelservice/controller/hotel_Homecontroller.dart';

class AddProductDialog extends StatelessWidget {
  AddProductDialog({Key? key}) : super(key: key);
  var _formKey = GlobalKey<FormState>();

  HomeController homeController = Get.put(HomeController());
  hotelHomeController HotelhomeController = Get.put(hotelHomeController());

  var size, height, width;
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<hotelHomeController>().RetrivingCAtegryInit();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              'Add Product',
              style: TextStyle(fontSize: 30),
            )),
            Container(
                //color: Colors.black,
                height: height / 6,
                width: width / 2,
                child: Image.asset('assets/images/addprocts.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
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
                              'Hotel Name:' +
                                  HotelhomeController.SharedpreFHotelNAMe
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            )),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Obx(
                              (() => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 197, 197, 197),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: DropdownButton(
                                      icon: Icon(Icons.category_rounded),
                                      hint: Text(
                                        'Category' +
                                            homeController.Categorychoose.value,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                      // value: controller.valuechoose.value,
                                      items: HotelhomeController.category
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
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Obx(() => Visibility(
                                    replacement: Icon(Icons.check_circle_sharp),
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
                                child: TextFormField(
                                  enabled: homeController.textfeildEnable.value,
                                  controller: homeController.UPLoadProctID,
                                  decoration: InputDecoration(
                                      labelText: 'Product id',
                                      hintText: 'Product ID',
                                      hintStyle: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 181, 181, 181)),
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 234, 240, 245),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      )),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return value = ('Enter Product Id!');
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: homeController.UPLoadProctName,
                                decoration: InputDecoration(
                                    hintText: 'Enter Product Name',
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 181, 181, 181)),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 234, 240, 245),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return value = ('Enter Product Name!');
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return value = ('Enter Product Description!');
                            }
                            return null;
                          },
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
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: homeController.UPLoadProctPrice,
                                decoration: InputDecoration(
                                    hintText: '   ₹',
                                    hintStyle: TextStyle(
                                        fontSize: 23,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 234, 240, 245),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    )),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return value = ('Enter Product Price!');
                                  }
                                  return null;
                                },
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                ' UPLOAD IMAGE:',
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    homeController.selectFile();
                                  },
                                  child: Text('SELECT IMAGE')),
                              Obx(() => Visibility(
                                    visible:
                                        homeController.ImagePikStatus.value,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Color.fromARGB(255, 13, 117, 17),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Obx(() => ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 6, 83, 9)),
                      onPressed: homeController.isloading.value
                          ? null
                          : () {
                              _submit();
                              //   homeController.Formsubmit();
                              //  homeController.UpLOAdAlldAta();
                            },
                      icon: homeController.isloading.value
                          ? TweenAnimationBuilder(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: Duration(seconds: 4),
                              builder: (context, value, _) => Container(
                                  height: 9,
                                  width: 9,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.green,
                                    strokeWidth: 2,
                                  )))
                          : Icon(Icons.upload),
                      label: Text(homeController.isloading.value
                          ? 'Processing..'
                          : 'UPLOAD'),
                    ))
                // ElevatedButton(
                //     onPressed: () {
                //       homeController.Formsubmit();
                //       homeController.UpLOAdAlldAta();

                //       // homeController.uploadFile();
                //     },
                //     child: Text('Upload'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
