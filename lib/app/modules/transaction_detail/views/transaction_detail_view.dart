import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends StatelessWidget {
  final TransactionDetailController controller = Get.find();

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
                  onTap: () => Get.toNamed(Routes.RECORD_DEBT, arguments: {
                    "doc": controller.argDoc,
                    "type": "EDIT",
                    "id": controller.argId
                  }),
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
                  controller.argDoc['date'] != null
                      ? Utils().timestampToDateFormat(controller.argDoc['date'])
                      : "",
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
                      '082144285606',
                      style: TextStyle(color: Color(grey), fontSize: 15),
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
                          'Nama',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                        Text(
                          'Nomor HP',
                          style: TextStyle(color: Color(grey), fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.argDoc['name'],
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
                            controller.argDoc['type'] == 'UTANG'
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
                                .format(controller.argDoc['amount'])
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
                      controller.argDoc['note'].toString() == ''
                          ? '-'
                          : controller.argDoc['note'],
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
                              .format(controller.argCount)
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
                          'Rp.0',
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
                          'Rp.5.000.000',
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              //   child: Row(
              //     children: [
              //       Switch(
              //         value: true,
              //         onChanged: (value) {},
              //         activeTrackColor: Color(blueBackground),
              //         activeColor: Color(blue),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text(
              //         'Tampilkan detail sisa utang',
              //         style: TextStyle(color: Color(grey), fontSize: 17),
              //       ),
              //     ],
              //   ),
              // )
            ],
          )),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(white),
                    side: BorderSide(color: Color(yellow))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.printer,
                      color: Color(yellow),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Cetak Nota",
                      style: TextStyle(color: Color(yellow)),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
