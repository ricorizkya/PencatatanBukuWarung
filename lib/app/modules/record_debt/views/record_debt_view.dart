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
            padding: EdgeInsets.fromLTRB(16, 0, 16, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text("Memberikan ke :"),
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
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: controller.phoneC,
                  decoration: InputDecoration(
                    labelText: 'Nomor HP',
                    prefixIcon: Icon(CupertinoIcons.phone),
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
                Text("Memberikan sejumlah"),
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
                  height: 10,
                ),
                Text("Jatuh Tempo"),
                Row(
                  children: [
                    Icon(CupertinoIcons.calendar),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: DateTimeField(
                        controller: controller.dateC,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration: InputDecoration(hintText: "2020-12-31"),
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
                  controller.type != 'EDIT'
                      ? controller.addTransaction(
                          controller.nameC.text,
                          int.parse(
                              controller.amountC.text.replaceAll('.', '')),
                          controller.dateC.text,
                          controller.noteC.text,
                          controller.phoneC.text)
                      : controller.editTransaction(
                          "",
                          controller.nameC.text,
                          int.parse(
                              controller.amountC.text.replaceAll('.', '')),
                          controller.dateC.text,
                          controller.noteC.text,
                          controller.phoneC.text);
                },
                child: Text("Simpan"),
              ),
            ),
          )),
    );
  }
}
