import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tablet_controller.dart';

class TabletView extends GetView<TabletController> {
  const TabletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabletView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TabletView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
