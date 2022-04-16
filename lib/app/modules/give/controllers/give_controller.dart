import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:uuid/uuid.dart';

class GiveController extends GetxController {
  final amountC = TextEditingController(text: "0");
  final noteC = TextEditingController();
  final dateC = TextEditingController();
  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol + " ";

  var argId = Get.arguments['id'];
  var argDoc = Get.arguments['doc'];
  var argDocDetail = Get.arguments['docDetail'];
  var argType = Get.arguments['type'];
  var argAction = Get.arguments['action'];

  void addTransaction(int amount, String note) async {
    if (amount == 0) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Isi semua data dengan benar",
          textConfirm: "OKE",
          onConfirm: () => Get.back());
      return;
    }

    var newDetail = {
      "id": Uuid().v1(),
      "amount": amount,
      "note": note,
      "type": argType,
      "createdDate": DateTime.now(),
    };

    var newAmount = reArrangeAMountAdd(argDoc['detail'], newDetail);

    await RestProvider().editData('transaction', argId, {
      "amount": newAmount,
      "detail": FieldValue.arrayUnion([newDetail]),
    });

    Get.defaultDialog(
        title: "Sukses",
        middleText: "Add data berhasil",
        onConfirm: () {
          Get.back();
          Get.back(result: 'success');
        });
  }

  void editTransaction(int amount, String note) async {
    print(argId);
    try {
      if (amount == 0) {
        Get.defaultDialog(
            title: "Error",
            middleText: "Isi semua data dengan benar",
            textConfirm: "OKE",
            onConfirm: () => Get.back());
        return;
      }

      var newDetail = updateDetail(argDoc['detail'], argDocDetail['id']);
      var newAmount = reArrangeAMountEdit(argDoc['detail']);

      await RestProvider().editData('transaction', argId, {
        "amount": newAmount,
        "detail": newDetail,
      });

      Get.defaultDialog(
          title: "Sukses",
          middleText: "Edit data berhasil",
          onConfirm: () {
            Get.back();
            Get.back(result: 'success');
          });
    } on Exception catch (e) {
      print(e);
      Get.snackbar('Error', 'Gagal edit data',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  updateDetail(var allDetail, String id) {
    allDetail
        .map((e) => {
              if (e['id'] == id)
                {
                  e['amount'] = int.parse(amountC.text.replaceAll('.', '')),
                  e['note'] = noteC.text,
                }
            })
        .toList();

    return allDetail;
  }

  reArrangeAMountAdd(var allDetail, var newDetail) {
    num total = 0;
    allDetail.add(newDetail);
    allDetail.forEach((e) => {
          if (e['type'] == 'PINJAM') {total = total + e['amount']}
        });

    return total;
  }

  reArrangeAMountEdit(var allDetail) {
    num total = 0;
    allDetail.forEach((e) => {
          if (e['type'] == 'PINJAM') {total = total + e['amount']}
        });

    return total;
  }

  @override
  void onInit() {
    argAction == 'EDIT'
        ? amountC.text = formatNumber(argDocDetail['amount'].toString())
        : amountC.text = "0";
    argAction == 'EDIT' ? noteC.text = argDocDetail['note'] : noteC.text = "";
    super.onInit();
  }
}
