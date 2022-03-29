import 'package:get/get.dart';

import '../controllers/record_debt_controller.dart';

class RecordDebtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordDebtController>(
      () => RecordDebtController(),
    );
  }
}
