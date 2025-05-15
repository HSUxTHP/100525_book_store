import 'package:get/get.dart';

import '../modules/desktop/bindings/desktop_binding.dart';
import '../modules/desktop/views/desktop_view.dart';
import '../modules/mobile/bindings/mobile_binding.dart';
import '../modules/mobile/views/mobile_view.dart';
import '../modules/responsive/bindings/responsive_binding.dart';
import '../modules/responsive/views/responsive_view.dart';
import '../modules/responsive/views/responsive_view.dart';
import '../modules/tablet/bindings/tablet_binding.dart';
import '../modules/tablet/views/tablet_view.dart';

import '../modules/desktop/views/detail_page.dart';
import '../modules/desktop/views/read_page.dart';
import '../modules/desktop/views/cart_page.dart';

import '../modules/mobile/views/detail_page.dart' as m;
import '../modules/mobile/views/read_page.dart' as m;
import '../modules/mobile/views/cart_page.dart' as m;

import '../modules/tablet/views/detail_page.dart' as t;
import '../modules/tablet/views/read_page.dart' as t;
import '../modules/tablet/views/cart_page.dart' as t;

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RESPONSIVE;

  static final routes = [
    GetPage(
      name: _Paths.DESKTOP,
      page: () => const DesktopView(),
      binding: DesktopBinding(),
    ),
    GetPage(
      name: _Paths.TABLET,
      page: () => const TabletView(),
      binding: TabletBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE,
      page: () => const MobileView(),
      binding: MobileBinding(),
    ),
    GetPage(
      name: _Paths.RESPONSIVE,
      page: () => const ResponsiveView(),
      binding: ResponsiveBinding(),
    ),

    GetPage(
      name: Routes.DETAIL,
      page: () {
        // final book = Get.arguments as Book;
        if (Get.width < 500) {
          return m.DetailPage();
        } else if (Get.width < 1367) {
          return t.DetailPage();
        } else {
          return DetailPage();
        }
      },
    ),

    GetPage(
      name: Routes.READ,
      page: () {
        if (Get.width < 500) {
          return m.ReadPage();
        } else if (Get.width < 1367) {
          return t.ReadPage();
        } else {
          return ReadPage();
        }
      },
    ),

    GetPage(
      name: Routes.CART,
      page: () {
        if (Get.width < 500) {
          return m.CartPage();
        } else if (Get.width < 1367) {
          return t.CartPage();
        } else {
          return CartPage();
        }
      },
    ),

    GetPage(
      name: Routes.DESKTOP,
      page: () => const DesktopView(),
      children: [
        GetPage(
          name: Routes.DETAIL,
          page: () => const DetailPage(),
        ),
        GetPage(
          name: Routes.READ,
          page: () => const ReadPage(),
        ),
      ],
    ),

    GetPage(
      name: Routes.MOBILE,
      page: () => const MobileView(),
      children: [
        GetPage(
          name: Routes.DETAIL,
          page: () => const m.DetailPage(),
        ),
        GetPage(
          name: '/read',
          page: () => const m.ReadPage(),
        ),
      ],
    ),

    GetPage(
      name: Routes.TABLET,
      page: () => const TabletView(),
      children: [
        GetPage(
          name: Routes.DETAIL,
          page: () => const t.DetailPage(),
        ),
        GetPage(
          name: '/read',
          page: () => const t.ReadPage(),
        ),
      ],
    ),
  ];
}
