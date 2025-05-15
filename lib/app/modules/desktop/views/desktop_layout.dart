import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/desktop_controller.dart';
import 'cart_page.dart';
import 'detail_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class DesktopLayout extends GetView<DesktopController> {
   DesktopLayout({super.key}) {
    // Get.put(DesktopController()); // Thêm dòng này
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
        title: Obx(
              () => Row(
            children: [
              _navButton('Home', Icons.home, 0),
              _navButton('Cart', Icons.shopping_cart, 1),
              _navButton('Profile', Icons.person, 2),
            ],
          ),
        ),
      ),
      drawer: Obx(
            () => Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      controller.selectedIndex.value == 0
                          ? 'Home'
                          : controller.selectedIndex.value == 1
                          ? 'Cart'
                          : 'Profile',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              _drawerTile('Home', Icons.home, 0),
              _drawerTile('Cart', Icons.shopping_cart, 1),
              _drawerTile('Profile', Icons.person, 2),
            ],
          ),
        ),
      ),
      body: Obx(() => _getPage(controller.selectedIndex.value)),
    );
  }

  Widget _navButton(String label, IconData icon, int index) {
    final isSelected = controller.selectedIndex.value == index;
    return TextButton.icon(
      onPressed: () => controller.setIndex(index),
      icon: Icon(icon, color: isSelected ? Colors.white : Colors.white70),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _drawerTile(String title, IconData icon, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        controller.setIndex(index);
        Get.back();
      },
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return const CartPage();
      case 2:
        return const ProfilePage();
      default:
        return  HomePage();
    }
  }
}
