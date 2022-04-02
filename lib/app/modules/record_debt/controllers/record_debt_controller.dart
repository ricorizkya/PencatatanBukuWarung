import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordDebtController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  var value = false.obs;
  var val = 1.obs;
  final nameC = TextEditingController();
  final amountC = TextEditingController();
  final noteC = TextEditingController();
  final dateC = TextEditingController();

  changeRadio(value) {
    val.value = value;
    update();
  }

  void addTransaction(String name, int amount, String date, String note) async {
    CollectionReference col = firestore.collection('transaction');

    var type = val == 1 ? "PIUTANG" : "UTANG";

    try {
      await col.add({
        "type": type,
        "name": name,
        "amount": amount,
        "date": date,
        "note": note
      });

      Get.defaultDialog(
          title: "Sukses",
          middleText: "Tambah data berhasil",
          onConfirm: () {
            Get.back();
            Get.back();
          });
    } on Exception catch (_) {
      Get.snackbar('Error', 'Failed add transaction',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
