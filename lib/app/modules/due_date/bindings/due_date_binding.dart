import 'package:get/get.dart';

import '../controllers/due_date_controller.dart';

class DueDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DueDateController>(
      () => DueDateController(),
    );
  }
}
