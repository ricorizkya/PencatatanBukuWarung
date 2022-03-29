import 'package:get/get.dart';

import '../controllers/resource_controller.dart';

class ResourceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResourceController>(
      () => ResourceController(),
    );
  }
}
