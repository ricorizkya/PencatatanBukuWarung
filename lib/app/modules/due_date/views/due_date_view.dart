import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/modules/home/controllers/home_controller.dart';
import 'package:los_pasar/app/routes/app_pages.dart';
import 'package:los_pasar/app/data/utils.dart';

import '../controllers/due_date_controller.dart';

class DueDateView extends GetView<DueDateController> {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender Jatuh Tempo'),
        centerTitle: false,
        bottom: TabBar(
          controller: controller.tabController,
          tabs: controller.myTabs,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return ListView(
            children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.argSnapshot.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> doc =
                        controller.argSnapshot.docs[index].data();
                    bool isTrue = false;

                    // timestamp to datetime
                    DateTime dueDate = DateTime.fromMillisecondsSinceEpoch(
                        doc['dueDate'].seconds * 1000);
                    DateTime dateTimeNow = DateTime.now();

                    // filter by due date
                    if (label == 'sudah lewat' &&
                        dateTimeNow.difference(dueDate).inDays > 0) {
                      isTrue = true;
                    } else if (label == 'hari ini' &&
                        dateTimeNow.difference(dueDate).inDays == 0) {
                      isTrue = true;
                    } else if (label == 'akan datang' &&
                        dateTimeNow.difference(dueDate).inDays < 0) {
                      isTrue = true;
                    }

                    if (isTrue &&
                        homeController.calculateDataAmount(doc['detail']) > 0) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var data = await Get.toNamed(Routes.DEBT_DETAIL,
                                  arguments: {
                                    "id": controller.argSnapshot.docs[index].id
                                  });

                              if (data == 'success')
                                homeController.calculateAmount();
                            },
                            child: ListTile(
                              title: Text(
                                doc['name'].toString().toTitleCase(),
                              ),
                              subtitle: Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "Jatuh Tempo: ",
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text: Utils()
                                        .timestampToDateFormat(doc['dueDate']),
                                    style: TextStyle(fontSize: 12))
                              ])),
                              leading: CircleAvatar(
                                  child: Text("S")), //awalan pada circle image
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Column(
                                  children: [
                                    doc['type'] == "UTANG"
                                        ? Text(
                                            Utils()
                                                .currencyFormatter
                                                .format(homeController
                                                    .calculateDataAmount(
                                                        doc['detail']))
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(green),
                                                fontSize: 20))
                                        : Text(
                                            Utils()
                                                .currencyFormatter
                                                .format(homeController
                                                    .calculateDataAmount(
                                                        doc['detail']))
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(red),
                                                fontSize: 20)),
                                    doc['type'] == "UTANG"
                                        ? Text("Utang Saya",
                                            style: TextStyle(
                                                color: Color(grey),
                                                fontSize: 12))
                                        : Text("Utang Pelanggan",
                                            style: TextStyle(
                                                color: Color(grey),
                                                fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Color(divider),
                            thickness: 1,
                            indent: Get.width * 0.15,
                          ),
                        ],
                      );
                    } else {
                      return Center();
                    }
                  })
            ],
          );
        }).toList(),
      ),
    );
  }
}
