import 'package:get/get.dart';
import 'package:los_pasar/app/modules/print/controllers/print_controller.dart';

class PrintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrintController>(() => PrintController());
  }
}
