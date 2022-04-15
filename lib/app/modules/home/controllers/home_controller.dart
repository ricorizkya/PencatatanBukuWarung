import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';

class HomeController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final transaction = FirebaseFirestore.instance.collection('transaction');

  var utangSaya = 0.obs;
  var utangPelanggan = 0.obs;

  // Future<QuerySnapshot<Object?>> getListData() async {
  //   // get transaction firestore order by date
  //   return await transaction.orderBy('createdDate', descending: true).get();
  // }

  Future<QuerySnapshot<Object?>> getListData() async {
    return RestProvider().getAllData('transaction', 'createdDate', false);
  }

  // Future<int> getCount(type) async {
  //   final data = await transaction.where('type', isEqualTo: type).get();

  //   int totalCount = 0;

  //   data.docs.forEach(
  //     (doc) {
  //       totalCount += doc.data()['amount'] as int;
  //     },
  //   );
  //   return totalCount;
  // }

  @override
  void onInit() async {
    // utangSaya.value = await getCount('UTANG');
    // utangPelanggan.value = await getCount('PIUTANG');
    super.onInit();
  }
}
