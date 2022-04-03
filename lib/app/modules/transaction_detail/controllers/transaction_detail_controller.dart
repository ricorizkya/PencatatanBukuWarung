import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/routes/app_pages.dart';

class TransactionDetailController extends GetxController {
  final argDoc = Get.arguments['doc'];
  final argCount = Get.arguments['count'];
  final argId = Get.arguments['id'];

  final transaction = FirebaseFirestore.instance.collection('transaction');

  void deleteTransaction() {
    Get.defaultDialog(
        title: "Konfirmasi",
        middleText: "Yakin hapus data?",
        textCancel: "BATAL",
        onCancel: () {
          // Get.back();
        },
        textConfirm: "OKE",
        onConfirm: () async {
          await transaction.doc(argId).delete();
          Get.offAllNamed(Routes.HOME);
        });
  }
}
