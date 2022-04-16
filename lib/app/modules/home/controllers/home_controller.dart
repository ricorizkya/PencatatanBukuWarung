import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with StateMixin<QuerySnapshot<Map<String, dynamic>>> {
  final transaction = FirebaseFirestore.instance.collection('transaction');

  var utangSaya = 0.obs;
  var utangPelanggan = 0.obs;
  var jatuhTempo = 0.obs;

  calculateAmount() {
    transaction.snapshots().listen((snapshot) {
      change(snapshot, status: RxStatus.success());
      snapshot.docs.forEach((doc) {
        var data = doc.data();
        utangSaya.value = 0;
        utangPelanggan.value = 0;
        data['detail'].forEach((detail) {
          if (detail['type'] == 'BAYAR') {
            utangSaya += detail['amount'];
          } else {
            utangPelanggan += detail['amount'];
          }
        });

        // if dueDate lower than today
        if (data['dueDate'] != null) {
          // timestamp to datetime
          var dueDate = DateTime.fromMillisecondsSinceEpoch(
              data['dueDate'].seconds * 1000);
          var now = DateTime.now();
          if (dueDate.isBefore(now)) {
            jatuhTempo += 1;
          }
        }
      });
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
    calculateAmount();
    super.onInit();
  }
}
