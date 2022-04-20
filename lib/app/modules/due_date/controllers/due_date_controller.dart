import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DueDateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Sudah Lewat'),
    Tab(text: 'Hari Ini'),
    Tab(text: 'Akan Datang'),
  ];

  late TabController tabController;
  QuerySnapshot<Map<String, dynamic>> argSnapshot = Get.arguments['snapshot'];

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 1);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
