import 'package:get/get.dart';
import 'countdown_tap_settings_logic.dart';

class CountdownTapSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountdownTapSettingsLogic());
  }
}

