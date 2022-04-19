import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class RecordDebtController extends GetxController {
  CollectionReference col =
      FirebaseFirestore.instance.collection('transaction');
  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  var value = false.obs;
  final nameC = TextEditingController();
  final phoneC = TextEditingController();
  final amountC = TextEditingController(text: "0");
  final noteC = TextEditingController();
  final dateC = TextEditingController();

  var argAction = Get.arguments['action'];
  var argSnapshot = Get.arguments['snapshot'];

  void addTransaction(
      String name, int amount, String date, String note, String phone) async {
    try {
      if (name.isEmpty || amount == 0 || date.isEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Isi semua data dengan benar",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      var check =
          await RestProvider().getDataWhere('transaction', 'name', name);
      if (check.docs.isNotEmpty) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Nama sudah ada",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      await RestProvider().addData('transaction', {
        "name": name.toLowerCase(),
        "phone": phone,
        "dueDate": DateTime.parse(date),
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

  updateData(String id, String name, String phone, String date) async {
    if (name.isEmpty || date.isEmpty) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Isi semua data dengan benar",
          textConfirm: "OKE",
          onConfirm: () => Get.back());
      return;
    }

    await RestProvider().editData('transaction', id, {
      "name": name.toLowerCase(),
      "phone": phone,
      "dueDate": DateTime.parse(date),
    });

    Get.defaultDialog(
        title: "Sukses",
        middleText: "Edit data berhasil",
        onConfirm: () {
          Get.offAllNamed(Routes.HOME);
        });
  }

  @override
  void onInit() {
    if (argAction == 'EDIT') {
      var doc = argSnapshot.data() as Map<String, dynamic>;
      argAction == 'EDIT' ? nameC.text = doc['name'] : nameC.text = '';
      argAction == 'EDIT' ? phoneC.text = doc['phone'] : phoneC.text = '';
      var datetime = DateTime.fromMicrosecondsSinceEpoch(
          doc['dueDate'].microsecondsSinceEpoch);
      argAction == 'EDIT'
          ? dateC.text = DateFormat('yyyy-MM-dd').format(datetime)
          : dateC.text = '';
    }

    super.onInit();
  }
}
