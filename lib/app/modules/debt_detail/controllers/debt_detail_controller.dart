import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DebtDetailController extends GetxController {
  final transaction = FirebaseFirestore.instance.collection('transaction');
  var argDoc = Get.arguments['doc'];
  var argId = Get.arguments['id'];
  var count = 0.obs;

  Future<QuerySnapshot<Object?>> getListData() async {
    // get transaction firestore order by date and where
    final data = await transaction
        .orderBy('date', descending: true)
        .where('name', isEqualTo: argDoc['name'])
        .get();
    // final data =
    //     await transaction.where('name', isEqualTo: argDoc['name']).get();

    int totalCount = 0;

    data.docs.forEach(
      (doc) {
        if (doc.data()['type'] == 'PIUTANG')
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
