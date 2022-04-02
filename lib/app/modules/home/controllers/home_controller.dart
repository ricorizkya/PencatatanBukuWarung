import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference transaction = firebase.collection('transaction');

    return transaction.get();
  }
}
