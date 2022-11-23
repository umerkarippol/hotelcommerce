import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:hotelservice/controller/cartcontroller.dart';

class OrderButton extends StatelessWidget {
  final String value;
  final String title;
  const OrderButton({required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(builder: (buttonController) {
      return InkWell(
        onTap: () => buttonController.setOrderType(value),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: buttonController.orderType,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (String? value) {},
              activeColor: Colors.amber,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(fontFamily: 'muli', fontSize: 20),
            ),
          ],
        ),
      );
    });
  }
}
