import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.RECORD_DEBT);
        },
        icon: Icon(
          CupertinoIcons.add,
          color: Color(black),
        ),
        label: Text(
          "CATAT UTANG",
          style: TextStyle(color: Color(black)),
        ),
        backgroundColor: Color(yellow),
      ),
      appBar: AppBar(
        backgroundColor: Color(blue),
        centerTitle: false,
        title: ListTile(
          // contentPadding: EdgeInsets.only(left: 10, right: 10),
          title: Text(
            "Retribusi Warung",
            style: TextStyle(
                color: Color(white), fontWeight: FontWeight.bold, fontSize: 20),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(white),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.fromLTRB(20, 3, 20, 3),
                  child: Row(
                    children: [
                      Text("Jatuh Tempo", style: TextStyle(color: Color(blue))),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(grey), shape: BoxShape.circle),
                        child: Text("0",
                            style:
                                TextStyle(color: Color(white), fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            width: Get.width * 0.40,
                            child: Column(
                              children: [
                                Text("Utang Saya"),
                                SizedBox(
                                  height: 5,
                                ),
                                Obx(() => Text(
                                    controller.currencyFormatter
                                        .format(controller.utangSaya.value)
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(green), fontSize: 20)))
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Color(divider),
                            thickness: 1,
                            width: 0,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: Get.width * 0.40,
                            child: Column(
                              children: [
                                Text("Utang Pelanggan"),
                                SizedBox(
                                  height: 5,
                                ),
                                Obx(() => Text(
                                    controller.currencyFormatter
                                        .format(controller.utangPelanggan.value)
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(red), fontSize: 20)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(divider),
                      thickness: 1,
                      height: 0,
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.doc_chart_fill),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Lihat Laporan Utang")
                              ],
                            ),
                            Icon(
                              CupertinoIcons.back,
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Divider(
              color: Color(divider),
              height: 0,
              thickness: 1,
            ),
            FutureBuilder<QuerySnapshot<Object?>>(
                future: controller.getListData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> doc = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.DEBT_DETAIL,
                                    arguments: {"trx": doc[index]}),
                                child: ListTile(
                                  title: Text(
                                    doc['name'],
                                  ),
                                  subtitle: Text(
                                    "Jatuh Tempo: 18 Mar 2022",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  leading: CircleAvatar(
                                      child:
                                          Text("S")), //awalan pada circle image
                                  trailing: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Column(
                                      children: [
                                        doc['type'] == "UTANG"
                                            ? Text(
                                                controller.currencyFormatter
                                                    .format(doc['amount'])
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color(green),
                                                    fontSize: 20))
                                            : Text(
                                                controller.currencyFormatter
                                                    .format(doc['amount'])
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
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
