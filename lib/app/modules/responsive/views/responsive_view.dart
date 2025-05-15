import 'package:book_store/app/modules/responsive/controllers/responsive_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../data/models/book_model.dart';
import '../../../routes/app_pages.dart';
import '../../desktop/controllers/desktop_controller.dart';
import '../../desktop/views/desktop_layout.dart';
import '../../desktop/views/cart_page.dart' as d;
import '../../desktop/views/detail_page.dart' as d;
import '../../desktop/views/profile_page.dart' as d;
import '../../desktop/views/read_page.dart' as d;

import '../../mobile/controllers/mobile_controller.dart';
import '../../mobile/views/mobile_layout.dart';
import '../../mobile/views/cart_page.dart';
import '../../mobile/views/detail_page.dart';
import '../../mobile/views/profile_page.dart';
import '../../mobile/views/read_page.dart';

import '../../tablet/controllers/tablet_controller.dart';
import '../../tablet/views/tablet_layout.dart';
import '../../tablet/views/cart_page.dart' as t;
import '../../tablet/views/detail_page.dart' as t;
import '../../tablet/views/profile_page.dart' as t;
import '../../tablet/views/read_page.dart' as t;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/book_model.dart';
import '../../desktop/views/desktop_layout.dart';
import '../../mobile/views/mobile_layout.dart';
import '../../tablet/views/tablet_layout.dart';
import '../bindings/responsive_binding.dart';

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.width < 500) {
      return MobileLayout();
    } else if (Get.width < 1367) {
      return TabletLayout();
    } else {
      return DesktopLayout();
    }
  }
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const ResponsiveView(),
      binding: ResponsiveBinding(),
      children: [
        GetPage(
          name: Routes.CART,
          page: () {
            if (Get.width < 500) return const CartPage();
            if (Get.width < 1367) return const t.CartPage();
            return const d.CartPage();
          },
        ),
        GetPage(
          name: Routes.DETAIL,
          page: () {
            // final book = Get.arguments as Book;
            if (Get.width < 500) return DetailPage();
            if (Get.width < 1367) return t.DetailPage();
            return d.DetailPage();
          },
        ),
        GetPage(
          name: Routes.PROFILE,
          page: () {
            if (Get.width < 500) return const ProfilePage();
            if (Get.width < 1367) return const t.ProfilePage();
            return const d.ProfilePage();
          },
        ),
        GetPage(
          name: Routes.READ,
          page: () {
            // final book = Get.arguments as Book;
            if (Get.width < 500) return ReadPage();
            if (Get.width < 1367) return t.ReadPage();
            return d.ReadPage();
          },
        ),
      ],
    ),
  ];
}
