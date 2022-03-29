import 'package:get/get.dart';

import '../controllers/debt_detail_controller.dart';

class DebtDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebtDetailController>(
      () => DebtDetailController(),
    );
  }
}
