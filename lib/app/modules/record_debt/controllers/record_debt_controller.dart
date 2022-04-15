import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class RecordDebtController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  var doc = Get.arguments['doc'];
  var type = Get.arguments['type'];

  var value = false.obs;
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final amountC = TextEditingController(text: "0");
  final noteC = TextEditingController();
  final dateC = TextEditingController();

  void addTransaction(
      String name, int amount, String date, String note, String phone) async {
    CollectionReference col = firestore.collection('transaction');

    try {
      if (name.isEmpty || amount == 0 || date.isEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Isi semua data dengan benar",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      var check = await col.where('name', isEqualTo: name).get();
      if (check.docs.isNotEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Nama sudah ada",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      await col.add({
        "name": name.toLowerCase(),
        "phone": phone,
        "amount": amount,
        "dueDate": DateTime.parse(date),
        "note": note,
        "status": "BELUM LUNAS",
        "detail": [
          {
            "id": Uuid().v1(),
            "amount": amount,
            "note": note,
            "type": "PINJAM",
            "createdDate": DateTime.now(),
          }
        ],
        "createdDate": DateTime.now(),
      });

      Get.defaultDialog(
          title: "Sukses",
          middleText: "Tambah data berhasil",
          onConfirm: () {
            Get.offAllNamed(Routes.HOME);
          });
    } on Exception catch (_) {
      Get.snackbar('Error', 'Tambah data gagal',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void editTransaction(String id, String name, int amount, String date,
      String note, String phone) async {
    CollectionReference col = firestore.collection('transaction');

    try {
      if (name.isEmpty || amount == 0 || date.isEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Isi semua data dengan benar",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      await col.doc(id).update({
        "name": name.toLowerCase(),
        "phone": phone,
        "amount": amount,
        "date": DateTime.parse(date),
        "note": note
      });

      Get.defaultDialog(
          title: "Sukses",
          middleText: "Edit data berhasil",
          onConfirm: () {
            Get.offAllNamed(Routes.HOME);
          });
    } on Exception catch (_) {
      Get.snackbar('Error', 'Gagal edit data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onInit() {
    this.nameC.text = type == 'EDIT' ? doc['name'] : "";
    this.phoneC.text = type == 'EDIT' ? doc['phone'] : "";
    this.amountC.text = (type == 'EDIT'
        ? formatNumber(doc['amount'].toString().replaceAll(',', ''))
        : "");
    this.noteC.text = type == 'EDIT' ? doc['note'] : "";
    this.dateC.text = type == 'EDIT'
        ? DateFormat("yyyy-MM-dd").format(doc['date'].toDate())
        : "";
    super.onInit();
  }
}
