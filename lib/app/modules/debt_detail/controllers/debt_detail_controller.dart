import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/modules/home/controllers/home_controller.dart';

class DebtDetailController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final HomeController homeController = Get.find();

  final transaction = FirebaseFirestore.instance.collection('transaction');
  var argId = Get.arguments['id'];
  var doc;

  getTransactionById(String id) async {
    RestProvider().getDataById('transaction', id).then((value) {
      var data = value.data() as Map<String, dynamic>;
      doc = data;
      change(data, status: RxStatus.success());
    });
  }

  int calculateDataAmount(var docDetail) {
    var amount = 0;
    docDetail.forEach((x) {
      if (x['type'] == 'PINJAM') amount += x['amount'] as int;
    });
    return amount;
  }

  @override
  void onInit() async {
    getTransactionById(argId);
    // await this.getListData();
    super.onInit();
  }
}
