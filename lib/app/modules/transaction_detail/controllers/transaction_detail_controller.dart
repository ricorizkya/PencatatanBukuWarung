import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/modules/debt_detail/controllers/debt_detail_controller.dart';
import 'package:los_pasar/app/modules/home/controllers/home_controller.dart';

class TransactionDetailController extends GetxController {
  final transaction = FirebaseFirestore.instance.collection('transaction');
  final DebtDetailController debtDetailController = Get.find();
  final HomeController homeController = Get.find();

  var argId = Get.arguments['id'];
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
}
