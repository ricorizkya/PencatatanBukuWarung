import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/data/constant.dart';

import '../controllers/record_debt_controller.dart';

class RecordDebtView extends StatelessWidget {
  final RecordDebtController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catat Utang'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: Obx(
                  () => GestureDetector(
                    onTap: () => controller.changeRadio(1),
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          color: controller.val.value == 1
                              ? Color(red)
                              : Color(greyBackground),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: controller.val.value,
                            onChanged: (value) {
                              controller.changeRadio(value);
                            },
                            activeColor: Color(white),
                          ),
                          Text(
                            'Berikan',
                            style: TextStyle(
                                color: controller.val.value == 1
                                    ? Color(white)
                                    : Color(grey)),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                SizedBox(width: 5),
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => controller.changeRadio(2),
                      child: Container(
                        padding: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: controller.val.value == 2
                                ? Color(red)
                                : Color(greyBackground),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: controller.val.value,
                              onChanged: (value) {
                                controller.changeRadio(value);
                              },
                              activeColor: Color(white),
                            ),
                            Text(
                              'Terima',
                              style: TextStyle(
                                  color: controller.val.value == 2
                                      ? Color(white)
                                      : Color(grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(controller.val.value == 1
                    ? "Memberikan ke"
                    : "Terima dari")),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: controller.nameC,
                  decoration: InputDecoration(
                    labelText: 'Nama Pelanggan',
                    prefixIcon: Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(divider),
            thickness: 10,
            height: 0,
          ),
          Container(
            color: Color(blueBackground),
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(controller.val.value == 1
                    ? "Memberikan sejumlah"
                    : "Terima sejumlah")),
                SizedBox(
                  width: 40,
                ),
                Flexible(
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: controller.amountC,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(red)),
                    textAlign: TextAlign.right,
                    onChanged: (string) {
                      string =
                          '${controller.formatNumber(string.replaceAll(',', ''))}';
                      controller.amountC.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    },
                    decoration: InputDecoration(
                      prefixText: controller.currency,
                      prefixStyle: TextStyle(
                          color: Color(red),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(divider),
            thickness: 10,
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informasi Opsional"),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: controller.noteC,
                  decoration: InputDecoration(
                    labelText: 'Catatan',
                    prefixIcon: Icon(CupertinoIcons.square_favorites),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.calendar),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: DateTimeField(
                        controller: controller.dateC,
                        format: DateFormat("dd MMM yyyy"),
                        decoration: InputDecoration(hintText: "1 Jan 2020"),
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
                color: Color(white),
                border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(123, 158, 158, 158),
                        width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(yellow),
                ),
                onPressed: () {
                  controller.addTransaction(
                      controller.nameC.text,
                      int.parse(controller.amountC.text.replaceAll('.', '')),
                      controller.dateC.text,
                      controller.noteC.text);
                },
                child: Text("Simpan"),
              ),
            ),
          )),
    );
  }
}
