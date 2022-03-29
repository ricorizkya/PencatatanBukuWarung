import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/modules/resource/views/course_card_view.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

import '../controllers/resource_controller.dart';

class ResourceView extends GetView<ResourceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.4, 0.7, 0.5, 0.5],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xfffafdff),
            Color(0xfffafdff),
            Color(0xffE7FFFF),
            Color(0xffE7FFFF),
          ],
        ),
      ),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                        "assets/2.jpg",
                      ),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                          ),
                          Text(
                            "Pasar Plantungan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(blueBackground),
                                fontSize: 30,
                                letterSpacing: 1.9,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(white),
                                fontSize: 12,
                                letterSpacing: 1.9,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Selamat Datang Admin ^_^",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(black),
                                fontSize: 20,
                                letterSpacing: 1.9,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Container(
              height: 207,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCardView(
                      "Informasi Pasar Kambang", "24", "assets/3.jpg");
                },
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.HOME);
              },
              child: Container(
                height: 207,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CourseCardView("Retribusi", "24", "assets/1.jpg");
                  },
                ),
              ),
            ),
            Container(
              height: 207,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCardView("Sertifikasi", "24", "assets/4.jpg");
                },
              ),
            ),
            // ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   itemCount: 1,
            //   shrinkWrap: true,
            //   padding: EdgeInsets.all(0.0),
            //   physics: NeverScrollableScrollPhysics(),
            //   // ignore: missing_return
            //   itemBuilder: (BuildContext context, int index) {
            //     //return Recently();
            //   },
            // ),
          ],
        ),
      ),
    ));
  }
}
