import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final transaction = FirebaseFirestore.instance.collection('transaction');

  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  var utangSaya = 0.obs;
  var utangPelanggan = 0.obs;

  Future<QuerySnapshot<Object?>> getListData() async {
    return transaction.get();
  }

  Future<int> getCount(type) async {
    final data = await transaction.where('type', isEqualTo: type).get();

    int totalCount = 0;

    data.docs.forEach(
      (doc) {
        totalCount += doc.data()['amount'] as int;
      },
    );
    return totalCount;
  }

  @override
  void onInit() async {
    utangSaya.value = await getCount('UTANG');
    utangPelanggan.value = await getCount('PIUTANG');
    super.onInit();
  }
}
