import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';

import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends GetView<TransactionDetailController> {
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
                Column(
                  children: [
                    Icon(CupertinoIcons.pencil),
                    Text(
                      "Ubah",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Icon(CupertinoIcons.trash),
                    Text(
                      "Hapus",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
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
                  '25 Mar 2022 20:36',
                  style: TextStyle(color: Color(white)),
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
                      style: TextStyle(color: Color(grey)),
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
                          style: TextStyle(color: Color(grey)),
                        ),
                        Text(
                          'Nomor HP',
                          style: TextStyle(color: Color(grey)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Siti'),
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
                            'Memberikan',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Rp.5.000.000',
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
                      style: TextStyle(color: Color(grey)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '-',
                      style: TextStyle(color: Color(grey)),
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
                          'Rp.5.000.000',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Row(
                  children: [
                    Switch(
                      value: true,
                      onChanged: (value) {},
                      activeTrackColor: Color(blueBackground),
                      activeColor: Color(blue),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Tampilkan detail sisa utang',
                      style: TextStyle(color: Color(grey), fontSize: 17),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
