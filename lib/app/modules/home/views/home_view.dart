import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          color: Colors.black,
        ),
        label: Text(
          "CATAT UTANG",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[600],
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Retribusi Warung",
          style: TextStyle(),
        ),
      ),
      body: ListView(
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
                          width: Get.width * 0.45,
                          child: Column(
                            children: [
                              Text("Utang Saya"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Rp 2.500.000",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20))
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey[350],
                          thickness: 1,
                          width: 0,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          width: Get.width * 0.45,
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Text("Utang Pelanggan"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Rp 5.000.000",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20))
                            ],
                          ),
                        ),
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
            color: Colors.grey[350],
            height: 0,
            thickness: 1,
          ),
          ListTile(
            // contentPadding: EdgeInsets.only(left: 10, right: 10),
            title: Text(
              "Siti",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "Jatuh Tempo: 18 Mar 2022",
              style: TextStyle(fontSize: 12),
            ),
            leading: CircleAvatar(child: Text("S")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 5.000.000",
                      style: TextStyle(color: Colors.red, fontSize: 20)),
                  Text("Utang Pelanggan",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
          ListTile(
            title: Text(
              "Riko",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("R")), //awalan pada circle image
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Column(
                children: [
                  Text("Rp. 2.500.000",
                      style: TextStyle(color: Colors.green, fontSize: 20)),
                  Text("Utang Saya",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            thickness: 1,
            indent: Get.width * 0.15,
          ),
        ],
      ),
    );
  }
}
