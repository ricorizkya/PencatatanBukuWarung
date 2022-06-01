import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/modules/debt_detail/controllers/debt_detail_controller.dart';
import 'package:los_pasar/app/modules/home/controllers/home_controller.dart';
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';

class PrintController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final DebtDetailController debtDetailController = Get.find();
  final HomeController homeController = Get.find();
  final transactions = FirebaseFirestore.instance.collection('transaction');

  // PrinterBluetoothManager _printerBluetoothManager = PrinterBluetoothManager();
  // List<PrinterBluetooth> _device = [];

  // final  List<Map<String, dynamic>> data = [
  //   {
  //     'date': Get.arguments['createdDate'],
  //     'name': Get.arguments['named'],
  //     'phone': 10000,
  //     'status': 2,
  //     'amount': 20000,
  //     'note': 20000,
  //     'total': 20000,
  //     'paid': 20000,
  //     'paidAmount': 20000,
  //   },
  // ];

  var argId = Get.arguments['named'];
  var argDoc = Get.arguments['doc'];
  var argDocDetail = Get.arguments['docDetail'];
  var paidAmount = 0.obs;
  var insufficientPayment = 0.obs;

  countPaidAmount() {
    var total = 0;
    argDoc['detail'].forEach((element) {
      if (element['type'] == 'BAYAR') total += element['amount'] as int;
    });
    paidAmount.value = total;
    insufficientPayment.value = argDocDetail['amount'] - total;
  }

  @override
  void onInit() {
    countPaidAmount();
    super.onInit();
  }

  void deleteTransaction() {
    Get.defaultDialog(
        title: "Konfirmasi",
        middleText: "Yakin hapus data?",
        textCancel: "BATAL",
        textConfirm: "OKE",
        onConfirm: () async {
          var newAmount = reArrangeAMountDelete(argDoc['detail'], argDocDetail);

          await RestProvider().editData('transaction', argId, {
            "amount": newAmount,
            "detail": FieldValue.arrayRemove([argDocDetail]),
          });
          Get.back();
          Get.back(result: 'success');
        });
  }

  reArrangeAMountDelete(var allDetail, var docDetail) {
    print(allDetail);
    num total = 0;
    allDetail.remove(docDetail);
    allDetail.forEach((e) => {
          if (e['type'] == 'PINJAM') {total = total + e['amount']}
        });

    return total;
  }

  // initPrinter() {
  //   _printerBluetoothManager.startScan(Duration(seconds: 5));
  //   _printerBluetoothManager.scanResults.listen((event) {
  //     print(event);
  //   });
  // }
}
