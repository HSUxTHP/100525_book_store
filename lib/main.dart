import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/data/providers/cart_controller.dart';
import 'app/modules/desktop/controllers/desktop_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(CartController());
  Get.put(DesktopController());
  runApp(
    //Gắn database ở đây
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book store',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}