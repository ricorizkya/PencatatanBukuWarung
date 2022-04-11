import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/debt_detail_controller.dart';

class DebtDetailView extends StatelessWidget {
  final DebtDetailController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.only(left: 0),
          title: Text(controller.argDoc['name'],
              style: TextStyle(color: Color(white), fontSize: 20)),
          leading: CircleAvatar(
              child: Text(controller.argDoc['name'][0],
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(white)))), //awalan pada circle image
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                          width: Get.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Total Utang '),
                                    TextSpan(
                                      text: controller.argDoc['name'],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Obx(() => Text(
                                  Utils()
                                      .currencyFormatter
                                      .format(controller.count.value)
                                      .toString(),
                                  style: TextStyle(
                                      color: Color(red), fontSize: 20)))
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(yellow)),
                              onPressed: () {},
                              child: Text(
                                "Lunaskan",
                                style: TextStyle(color: Color(black)),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(grey),
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
                              Icon(CupertinoIcons.calendar),
                              SizedBox(
                                width: 5,
                              ),
                              Text.rich(TextSpan(children: [
                                TextSpan(text: "Jatuh Tempo "),
                                TextSpan(
                                    text: controller.argDoc['date'] == null
                                        ? "-"
                                        : Utils().timestampToDateFormat(
                                            controller.argDoc['date'])),
                              ]))
                            ],
                          ),
                          Icon(
                            CupertinoIcons.back,
                            color: Color(blue),
                            textDirection: TextDirection.rtl,
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 5),
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(CupertinoIcons.cloud_download),
                            Text("Laporan")
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Icon(CupertinoIcons.money_dollar),
                        //     Text("Tagih Utang")
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color(blueBackground),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Tanggal",
                    style: TextStyle(color: Color(grey)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Terima",
                    style: TextStyle(color: Color(grey)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Berikan",
                    style: TextStyle(color: Color(grey)),
                  ),
                )
              ],
            ),
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
                        return GestureDetector(
                          onTap: () => Get.toNamed(Routes.TRANSACTION_DETAIL,
                              arguments: {
                                "doc": doc,
                                "count": controller.count.value,
                                "id": snapshot.data!.docs[index].id
                              }),
                          child: Container(
                            height: 70,
                            color: Color(white),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  width: Get.width * 0.33,
                                  child: Text(
                                    doc['date'] == null
                                        ? "-"
                                        : Utils()
                                            .timestampToDateFormat(doc['date']),
                                    style: TextStyle(color: Color(grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  color: Color(0xFFE1FAF4),
                                  alignment: Alignment.center,
                                  width: Get.width * 0.33,
                                  child: Text(
                                    doc['type'] == 'UTANG'
                                        ? Utils()
                                            .currencyFormatter
                                            .format(doc['amount'])
                                            .toString()
                                        : '-',
                                    style: TextStyle(color: Color(grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  width: Get.width * 0.33,
                                  child: Text(
                                    doc['type'] == 'PIUTANG'
                                        ? Utils()
                                            .currencyFormatter
                                            .format(doc['amount'])
                                            .toString()
                                        : '-',
                                    style: TextStyle(color: Color(red)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color(white),
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(123, 158, 158, 158),
                        width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(red),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.GIVE, arguments: {
                          "id": controller.argId,
                          "doc": controller.argDoc
                        });
                      },
                      child: Text("Berikan"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(green),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.RECEIVE, arguments: {
                          "id": controller.argId,
                          "doc": controller.argDoc
                        });
                      },
                      child: Text("Terima"),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
