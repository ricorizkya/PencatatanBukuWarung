import 'package:get/get.dart';
import 'package:los_pasar/app/modules/record_debt/controllers/record_debt_controller.dart';

import '../controllers/give_controller.dart';

class GiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiveController>(() => GiveController());
    Get.lazyPut<RecordDebtController>(() => RecordDebtController());
  }
}
