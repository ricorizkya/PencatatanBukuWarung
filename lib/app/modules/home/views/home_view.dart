import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.RECORD_DEBT, arguments: {
            "type": "ADD",
          });
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
                color: Color(white), fontWeight: FontWeight.bold, fontSize: 17),
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.DUE_DATE,
                      arguments: {"snapshot": controller.dataSnapshot}),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(white),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                    child: Row(
                      children: [
                        Text("Jatuh Tempo",
                            style: TextStyle(color: Color(blue))),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(() => Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(red), shape: BoxShape.circle),
                              child: Text(
                                  controller.jatuhTempo.value.toString(),
                                  style: TextStyle(
                                      color: Color(white), fontSize: 12)),
                            )),
                      ],
                    ),
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
                          // Container(
                          //   padding: EdgeInsets.all(16),
                          //   width: Get.width * 0.40,
                          //   child: Column(
                          //     children: [
                          //       Text("Utang Saya"),
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       Obx(() => Text(
                          //           Utils()
                          //               .currencyFormatter
                          //               .format(controller.utangSaya.value)
                          //               .toString(),
                          //           style: TextStyle(
                          //               color: Color(green), fontSize: 20)))
                          //     ],
                          //   ),
                          // ),
                          // VerticalDivider(
                          //   color: Color(divider),
                          //   thickness: 1,
                          //   width: 0,
                          // ),
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
                                    Utils()
                                        .currencyFormatter
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
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REPORT);
                      },
                      child: Container(
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
                              Transform.scale(
                                scaleX: -1,
                                child: Icon(
                                  CupertinoIcons.back,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Color(divider),
              height: 0,
              thickness: 1,
            ),
            SizedBox(
              height: 8,
            ),
            controller.obx((snapshot) => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> doc = snapshot.docs[index].data();
                  if (controller.calculateDataAmount(doc['detail']) > 0) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var data = await Get.toNamed(Routes.DEBT_DETAIL,
                                arguments: {"id": snapshot.docs[index].id});

                            if (data == 'success') controller.calculateAmount();
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
                                              .format(controller
                                                  .calculateDataAmount(
                                                      doc['detail']))
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(green),
                                              fontSize: 20))
                                      : Text(
                                          Utils()
                                              .currencyFormatter
                                              .format(controller
                                                  .calculateDataAmount(
                                                      doc['detail']))
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(red), fontSize: 20)),
                                  doc['type'] == "UTANG"
                                      ? Text("Utang Saya",
                                          style: TextStyle(
                                              color: Color(grey), fontSize: 12))
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
                }))
          ],
        ),
      ),
    );
  }
}
