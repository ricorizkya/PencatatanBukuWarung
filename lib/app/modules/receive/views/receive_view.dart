import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/data/constant.dart';

import '../controllers/receive_controller.dart';

class ReceiveView extends GetView<ReceiveController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jumlah Yang Kamu Berikan'),
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
                onPressed: () {},
                child: Text("Simpan"),
              ),
            ),
          )),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 14, 16, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.08 + 10,
                          ),
                          Text("Terima"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.08,
                            child: Icon(
                              CupertinoIcons.text_badge_plus,
                              color: Color(green),
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controller.amount,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(green)),
                              onChanged: (string) {
                                string =
                                    '${controller.formatNumber(string.replaceAll(',', ''))}';
                                controller.amount.value = TextEditingValue(
                                  text: string,
                                  selection: TextSelection.collapsed(
                                      offset: string.length),
                                );
                              },
                              decoration: InputDecoration(
                                prefixText: controller.currency,
                                prefixStyle: TextStyle(
                                    color: Color(green),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          CupertinoIcons.pencil_ellipsis_rectangle,
                          color: Color(blue),
                        ),
                        labelText: 'Catatan',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        CupertinoIcons.calendar,
                        color: Color(blue),
                      ),
                      Flexible(
                        child: DateTimeField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                          format: DateFormat("dd MMM yyyy"),
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
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: false,
                  onChanged: (bool) {},
                  title: Text('Gratis: Kirim SMS notifikasi ke Siti'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
