import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

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
  final amountC = TextEditingController(text: "0");
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
      if (name.isEmpty || amount == 0 || date.isEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Isi semua data dengan benar",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

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
            Get.offAllNamed(Routes.HOME);
          });
    } on Exception catch (_) {
      Get.snackbar('Error', 'Failed add transaction',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
