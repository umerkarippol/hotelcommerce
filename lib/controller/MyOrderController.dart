import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/scannercontrolller.dart';

class MyOrderController extends GetxController {
  @override
  Future<void> onInit() async {
    scannercontroller controller = Get.put(scannercontroller());
    FirebaseFirestore Order_fire = FirebaseFirestore.instance;

    final collection = await Order_fire.collection('orders')
        .where('Coustomer Id', isEqualTo: controller.uidd);
    final order_data = collection.snapshots();
    print(order_data);

    // TODO: implement onInit
    super.onInit();
  }
}
