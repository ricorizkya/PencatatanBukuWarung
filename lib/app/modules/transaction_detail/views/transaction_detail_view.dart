import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends StatelessWidget {
  final TransactionDetailController controller = Get.find();

  // final List<Map<String, dynamic>> data = [
  //   {
  //     'date': controller.argDocDetail['createdDate'].toString(),
  //     'name': controller.argDoc['name'].toString(),
  //     'phone': controller.argDoc['phone'].toString(),
  //     'amount': controller.argDocDetail['amount'].toString(),
  //     'note': controller.argDocDetail['note'].toString()
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Detail Transaksi'),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    var data = await Get.toNamed(Routes.GIVE, arguments: {
                      'id': controller.argId,
                      'doc': controller.argDoc,
                      'docDetail': controller.argDocDetail,
                      'type': controller.argDocDetail['type'],
                      'action': 'EDIT'
                    });

                    if (data == 'success') {
                      Get.back(result: 'success');
                    }
                  },
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.pencil),
                      Text(
                        "Ubah",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () => controller.deleteTransaction(),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.trash),
                      Text(
                        "Hapus",
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Color(blue), Color(blueBackground)])),
                child: Text(
                  Utils().timestampToDateFormat(
                      controller.argDocDetail['createdDate']),
                  style: TextStyle(color: Color(white), fontSize: 17),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(white),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Warung Oke',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.check_mark_circled,
                          color: Color(green),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '084657894431',
                      style: TextStyle(color: Color(grey), fontSize: 15),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(divider),
                      height: 30,
                    ),
                    // Text(
                    //   'ID',
                    //   style: TextStyle(color: Color(grey), fontSize: 17),
                    // ),
                    // Text(
                    //     controller.argDocDetail['id'].toString().toTitleCase()),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nama',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                        Text(
                          'Nomor HP',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.argDoc['name'].toString().toTitleCase(),
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          controller.argDoc['phone'],
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      width: Get.width,
                      color: Color(greyBackground),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.argDocDetail['type'] == 'BAYAR'
                                ? 'Terima'
                                : 'Memberikan',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Utils()
                                .currencyFormatter
                                .format(
                                    controller.argDocDetail['amount'] as int)
                                .toString(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(divider),
                      height: 30,
                    ),
                    Text(
                      'Catatan',
                      style: TextStyle(color: Color(grey), fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.argDocDetail['note'].toString() == ''
                          ? '-'
                          : controller.argDocDetail['note'],
                      style: TextStyle(color: Color(grey), fontSize: 17),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(divider),
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Utang',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                        Text(
                          Utils()
                              .currencyFormatter
                              .format(controller.argDocDetail['amount'] as int)
                              .toString(),
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total sudah dibayar',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                        Text(
                          Utils()
                              .currencyFormatter
                              .format(controller.paidAmount.value)
                              .toString(),
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Kurang bayar',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                        Text(
                          Utils()
                              .currencyFormatter
                              .format(controller.insufficientPayment.value)
                              .toString(),
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(divider),
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Color(yellow),
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(123, 158, 158, 158),
                        width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: GestureDetector(
                onTap: () async {
                  var data = await Get.toNamed(Routes.PRINT, arguments: {
                    'id': controller.argId,
                    'doc': controller.argDoc,
                    'docDetail': controller.argDocDetail,
                    'type': controller.argDocDetail['type'],
                    // 'action': 'EDIT'
                  });

                  if (data == 'success') {
                    Get.back(result: 'success');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.printer,
                      color: Color(white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Cetak Nota",
                      style: TextStyle(color: Color(white)),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
