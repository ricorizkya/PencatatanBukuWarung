import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordDebtController extends GetxController {
  final amount = TextEditingController();
  static const _locale = 'id';
  String formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  var value = false.obs;
  var val = 1.obs;

  changeRadio(value) {
    val.value = value;
    update();
  }
}
