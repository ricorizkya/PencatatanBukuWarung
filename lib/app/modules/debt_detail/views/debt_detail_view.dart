import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/debt_detail_controller.dart';

class DebtDetailView extends GetView<DebtDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          // contentPadding: EdgeInsets.only(left: 10, right: 10),
          title: Text("Siti", style: TextStyle(color: Colors.white)),
          leading: CircleAvatar(
              child: Text("S",
                  style: TextStyle(
                      color: Colors.white))), //awalan pada circle image
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
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
                              Text("Total Utang Siti"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Rp 5.000.000",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20))
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amber[600]),
                              onPressed: () {},
                              child: Text(
                                "Lunaskan",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[350],
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
                              Text("Jatuh Tempo 18 Maret 2022")
                            ],
                          ),
                          Icon(
                            CupertinoIcons.back,
                            color: Colors.blue,
                            textDirection: TextDirection.rtl,
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
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
                        Column(
                          children: [
                            Icon(CupertinoIcons.money_dollar),
                            Text("Tagih Utang")
                          ],
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
            color: Colors.blue[50],
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Tanggal",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Terima",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Berikan",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "25 Maret 2022",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Color(0xFFE1FAF4),
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "-",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  width: Get.width * 0.33,
                  child: Text(
                    "Rp. 5.000.000",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
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
                        primary: Color(0xFFE50607),
                      ),
                      onPressed: () {},
                      child: Text("Berikan"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF23C39F),
                      ),
                      onPressed: () {},
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
