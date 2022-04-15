import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DebtDetailController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final transaction = FirebaseFirestore.instance.collection('transaction');
  var argId = Get.arguments['id'];

  getTransactionById(String id) async {
    transaction.doc(id).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      change(data, status: RxStatus.success());
    });
  }

  // get transaction firebase by id

  // Future<QuerySnapshot<Object?>> getListData() async {
  //   // get transaction firestore order by date and where
  //   final data = await transaction
  //       .orderBy('date', descending: true)
  //       .where('name', isEqualTo: argDoc['name'])
  //       .get();

  //   int totalCount = 0;

  //   data.docs.forEach(
  //     (doc) {
  //       if (doc.data()['type'] == 'PIUTANG')
  //         totalCount += doc.data()['amount'] as int;
  //     },
  //   );
  //   count.value = totalCount;

  //   return data;
  // }

  @override
  void onInit() async {
    getTransactionById(argId);
    // await this.getListData();
    super.onInit();
  }
}
