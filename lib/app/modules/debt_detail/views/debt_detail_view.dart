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
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: 'success');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            contentPadding: EdgeInsets.only(left: 0),
            title: controller.obx(
                (state) => Text(state!['name'].toString().toTitleCase(),
                    style: TextStyle(color: Color(white), fontSize: 20)),
                onLoading: Center()),
            leading: CircleAvatar(
                child: controller.obx(
                    (state) => Text(
                        state!['name'][0].toString().toCapitalized(),
                        style: TextStyle(fontSize: 20, color: Color(white))),
                    onLoading: Center())), //awalan pada circle image
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
                                controller.obx(
                                    (state) => Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: 'Total Utang '),
                                              TextSpan(
                                                text: state!['name']
                                                    .toString()
                                                    .toTitleCase(),
                                              ),
                                            ],
                                          ),
                                        ),
                                    onLoading: Center()),
                                SizedBox(
                                  height: 5,
                                ),
                                controller.obx((state) {
                                  var amount = controller.homeController
                                      .calculateDataAmount(state!['detail']);
                                  return Text(
                                      Utils()
                                          .currencyFormatter
                                          .format(amount)
                                          .toString(),
                                      style: TextStyle(
                                          color: Color(red), fontSize: 20));
                                }, onLoading: Center())
                              ],
                            ),
                          ),
                          controller.obx((state) {
                            var amount = controller.homeController
                                .calculateDataAmount(state!['detail']);
                            return amount > 0
                                ? Container(
                                    padding: EdgeInsets.all(16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(yellow)),
                                      onPressed: () {
                                        controller.payOff(amount);
                                      },
                                      child: Text(
                                        "Lunaskan",
                                        style: TextStyle(color: Color(black)),
                                      ),
                                    ))
                                : Center();
                          }, onLoading: Center()),
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
                                controller.obx(
                                    (state) => Text.rich(TextSpan(children: [
                                          TextSpan(text: "Jatuh Tempo "),
                                          TextSpan(
                                              text: Utils()
                                                  .timestampToDateFormat(
                                                      state!['dueDate'])),
                                        ])),
                                    onLoading: Center())
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
                          GetBuilder<DebtDetailController>(
                            builder: (_) {
                              return GestureDetector(
                                onTap: () {
                                  controller.createPDFFromData(
                                      context, controller.listData);
                                },
                                child: Column(
                                  children: [
                                    Icon(CupertinoIcons.cloud_download),
                                    Text("Laporan")
                                  ],
                                ),
                              );
                            },
                          ),
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
            controller.obx(
                (state) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state!['detail'].length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> doc = state['detail'][index];
                      return GestureDetector(
                        onTap: () async {
                          var data = await Get.toNamed(
                              Routes.TRANSACTION_DETAIL,
                              arguments: {
                                "id": controller.argId,
                                "doc": state,
                                "docDetail": doc
                              });

                          if (data == 'success') {
                            controller.getTransactionById(controller.argId);
                          }
                        },
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
                                  doc['createdDate'] == null
                                      ? "-"
                                      : Utils().timestampToDateFormat(
                                          doc['createdDate']),
                                  style: TextStyle(color: Color(grey)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                color: Color(0xFFE1FAF4),
                                alignment: Alignment.center,
                                width: Get.width * 0.33,
                                child: Text(
                                  doc['type'] == 'BAYAR'
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
                                  doc['type'] == 'PINJAM'
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
                    }),
                onLoading: Center()),
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
                        onPressed: () async {
                          var data = await Get.toNamed(Routes.GIVE, arguments: {
                            "type": 'PINJAM',
                            "id": controller.argId,
                            "doc": controller.doc
                          });

                          if (data == 'success') {
                            controller.getTransactionById(controller.argId);
                          }
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
                        onPressed: () async {
                          var data = await Get.toNamed(Routes.GIVE, arguments: {
                            "type": 'BAYAR',
                            "id": controller.argId,
                            "doc": controller.doc
                          });

                          if (data == 'success') {
                            controller.getTransactionById(controller.argId);
                          }
                        },
                        child: Text("Terima"),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
