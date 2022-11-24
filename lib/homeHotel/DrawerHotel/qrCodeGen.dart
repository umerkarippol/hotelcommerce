import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/home_DrawerController.dart';
import 'package:hotelservice/controller/hotel_Homecontroller.dart';
import 'package:hotelservice/controller/hotel_authContrlr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qRcoDEgeN extends StatelessWidget {
  qRcoDEgeN({Key? key}) : super(key: key);
  hotelHomeController hotelHomController = Get.put(hotelHomeController());
  HomeController hotelHOMEController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(hotelHomController.SharedpreFHotelId.toString()),
            RepaintBoundary(
              key: hotelHOMEController.ScrenShotkey,
              child: Center(
                child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: QrImage(
                    data: hotelHomController.SharedpreFHotelId.toString(),
                    size: 200,
                  ),
                ),
              ),
            ),
            Text(
              'Note:QrCode Cannot be Changed',
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            Obx(() => ElevatedButton(
                onPressed: () {
                  hotelHOMEController.takeScreenshot();
                },
                child: Text(hotelHOMEController.ButtonText.value)))
          ],
        ),
      ),
    );
  }
}
