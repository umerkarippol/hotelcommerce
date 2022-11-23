import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hotelservice/screen/home/screen_home.dart';

class bottom_nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screen_home.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedindex, _) {
        return BottomNavigationBar(
            currentIndex: updatedindex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            onTap: (newIndex) {
              screen_home.selectedIndexNotifier.value = newIndex;
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank,
                  size: 50,
                ),
                label: 'Vegitarion',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.food_bank_outlined, size: 50),
                  label: 'Non Vegitarion')
            ]);
      },
    );
  }
}
