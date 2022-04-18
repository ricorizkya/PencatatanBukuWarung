import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';

import '../controllers/report_controller.dart';

class ReportView extends StatelessWidget {
  final ReportController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: controller.obx(
          (state) => FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: new Text(
                                'Unduh Laporan',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Color(divider),
                              thickness: 1,
                              height: 10,
                            ),
                            ListTile(
                              title: new Text('Format File'),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    Obx(() => GestureDetector(
                                          onTap: () =>
                                              controller.isPdf.value = true,
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: controller.isPdf.isTrue
                                                    ? Color(blue)
                                                    : Color(greyBackground)),
                                            child: Row(
                                              children: [
                                                Icon(Icons.picture_as_pdf),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text("PDF")
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Obx(() => GestureDetector(
                                          onTap: () =>
                                              controller.isPdf.value = false,
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(10)),
                                                color: controller.isPdf.isFalse
                                                    ? Color(blue)
                                                    : Color(greyBackground)),
                                            child: Row(
                                              children: [
                                                Icon(CupertinoIcons
                                                    .doc_chart_fill),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text("Excel")
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(divider),
                              thickness: 10,
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(white),
                                  border: Border(
                                      top: BorderSide(
                                          color: Color.fromARGB(
                                              123, 158, 158, 158),
                                          width: 1.0))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: controller.obx((data) => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(white),
                                          side:
                                              BorderSide(color: Color(yellow))),
                                      onPressed: () {
                                        controller.isPdf.isTrue
                                            ? controller.createPDFFromData(
                                                context, data)
                                            : controller
                                                .createExcelFromData(data);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons.printer,
                                            color: Color(yellow),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Unduh",
                                            style:
                                                TextStyle(color: Color(yellow)),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          ],
                        );
                      });
                },
                icon: Icon(
                  Icons.download,
                  color: Color(black),
                ),
                label: Text(
                  "UNDUH LAPORAN",
                  style: TextStyle(color: Color(black)),
                ),
                backgroundColor: Color(yellow),
              ),
          onLoading: Center()),
      appBar: AppBar(
        title: Text('Laporan Utang Piutang'),
        centerTitle: false,
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
                                Obx(() => Text(
                                    Utils()
                                        .currencyFormatter
                                        .format(controller.utangSaya.value)
                                        .toString(),
                                    style: TextStyle(color: Color(green)))),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Terima",
                                    style: TextStyle(color: Color(green))),
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
                                Obx(() => Text(
                                    Utils()
                                        .currencyFormatter
                                        .format(controller.utangPelanggan.value)
                                        .toString(),
                                    style: TextStyle(color: Color(red)))),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Berikan",
                                    style: TextStyle(color: Color(red))),
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
                        child: Center(
                          child: Obx(() => Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: "Sisa utang saya ",
                                    style: TextStyle(color: Color(green))),
                                TextSpan(
                                    text: Utils()
                                        .currencyFormatter
                                        .format(controller.sisa.value)
                                        .toString(),
                                    style: TextStyle(color: Color(green)))
                              ]))),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pilih tanggal laporan"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Pilih waktu',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: controller.dayItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item['value'].toString(),
                                child: Text(
                                  item['label'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.changeDropdown(int.parse(value.toString()));
                      },
                      onSaved: (value) {
                        // selectedValue = value.toString();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Flexible(
                    child: DateTimeField(
                      onChanged: (value) {
                        if (controller.startC.text != '' &&
                            controller.endC.text != '')
                          controller.getAllDataBetweenDate(
                              DateTime.parse(controller.startC.text),
                              DateTime.parse(controller.endC.text));
                      },
                      controller: controller.startC,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(
                          hintText: "Tanggal Mulai",
                          icon: Icon(
                            Icons.calendar_month,
                            color: Color(blue),
                          )),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  Text(" - "),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: DateTimeField(
                      onChanged: (value) {
                        if (controller.startC.text != '' &&
                            controller.endC.text != '')
                          controller.getAllDataBetweenDate(
                              DateTime.parse(controller.startC.text),
                              DateTime.parse(controller.endC.text));
                      },
                      controller: controller.endC,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(
                          hintText: "Tanggal Akhir",
                          icon: Icon(
                            Icons.calendar_month,
                            color: Color(blue),
                          )),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Color(blueBackground),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.33,
                    child: Column(
                      children: [
                        Text(
                          "Transaksi",
                          style: TextStyle(
                            color: Color(black),
                          ),
                        ),
                        Obx(() => Text(
                              "${controller.transaksi} transaksi",
                              style:
                                  TextStyle(fontSize: 10, color: Color(grey)),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.33,
                    child: Column(
                      children: [
                        Text(
                          "Terima",
                          style: TextStyle(
                            color: Color(green),
                          ),
                        ),
                        Obx(() => Text(
                              "${controller.terima} transaksi",
                              style:
                                  TextStyle(fontSize: 10, color: Color(grey)),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.33,
                    child: Column(
                      children: [
                        Text(
                          "Berikan",
                          style: TextStyle(
                            color: Color(red),
                          ),
                        ),
                        Obx(() => Text(
                              "${controller.berikan} transaksi",
                              style:
                                  TextStyle(fontSize: 10, color: Color(grey)),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            controller.obx(
                (snapshot) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot!.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> doc = snapshot[index];
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            width: Get.width * 0.33,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['name'].toString().toTitleCase(),
                                  style: TextStyle(color: Color(black)),
                                ),
                                Text(
                                  doc['createdDate'] == null
                                      ? "-"
                                      : Utils().timestampToDateFormat(
                                          doc['createdDate']),
                                  style: TextStyle(color: Color(grey)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
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
                              style: TextStyle(color: Color(green)),
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
                      );
                    }),
                onLoading: Center()),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
