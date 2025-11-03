import 'package:get/get.dart';

import 'countdown_tap_main_logic.dart';

class CountdownTapMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CountdownTapMainLogic(),
      permanent: true,
    );
  }
}
