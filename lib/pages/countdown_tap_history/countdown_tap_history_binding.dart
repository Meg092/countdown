import 'package:get/get.dart';
import 'countdown_tap_history_logic.dart';

class CountdownTapHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountdownTapHistoryLogic());
  }
}

