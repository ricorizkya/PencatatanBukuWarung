import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DebtDetailController extends GetxController {
  final transaction = FirebaseFirestore.instance.collection('transaction');
  var argDoc = Get.arguments['doc'];
  var count = 0.obs;

  Future<QuerySnapshot<Object?>> getListData() async {
    final data =
        await transaction.where('name', isEqualTo: argDoc['name']).get();

    int totalCount = 0;

    data.docs.forEach(
      (doc) {
        totalCount += doc.data()['amount'] as int;
      },
    );
    count.value = totalCount;

    return data;
  }

  @override
  void onInit() async {
    await this.getListData();
    super.onInit();
  }
}
