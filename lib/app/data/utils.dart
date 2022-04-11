import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  String timestampToDateFormat(Timestamp timestamp) {
    var input =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(timestamp.toDate().toString());
    var output = DateFormat('dd MMM yyyy').format(input);
    return output;
  }
}
