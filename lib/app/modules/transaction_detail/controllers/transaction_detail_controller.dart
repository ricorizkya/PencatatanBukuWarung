import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/modules/debt_detail/controllers/debt_detail_controller.dart';

class TransactionDetailController extends GetxController {
  final transaction = FirebaseFirestore.instance.collection('transaction');
  final DebtDetailController debtDetailController = Get.find();
  var doc = Get.arguments['doc'];
  var docDetail = Get.arguments['docDetail'];
  var paidAmount = 0.obs;
  var insufficientPayment = 0.obs;

  countPaidAmount() {
    var total = 0;
    doc['detail'].forEach((element) {
      if (element['type'] == 'BAYAR') total += element['amount'] as int;
    });
    paidAmount.value = total;
    insufficientPayment.value = doc['amount'] - total;
  }

  @override
  void onInit() {
    countPaidAmount();
    super.onInit();
  }

  // void deleteTransaction() {
  //   Get.defaultDialog(
  //       title: "Konfirmasi",
  //       middleText: "Yakin hapus data?",
  //       textCancel: "BATAL",
  //       onCancel: () {
  //         // Get.back();
  //       },
  //       textConfirm: "OKE",
  //       onConfirm: () async {
  //         await transaction.doc(argId).delete();
  //         Get.offAllNamed(Routes.HOME);
  //       });
  // }
}
