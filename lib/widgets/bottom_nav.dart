import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/main_menu_controller.dart';

class BottomNavWidget extends StatelessWidget {
  final MainMenuController controller = Get.find<MainMenuController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote),
            label: 'Vote',
          ),
        ],
        selectedItemColor: Colors.blue, 
        unselectedItemColor: Colors.brown, 
      ),
    );
  }
}
