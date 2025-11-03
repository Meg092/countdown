import 'package:get/get.dart';
import 'countdown_tap_game_logic.dart';

class CountdownTapGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountdownTapGameLogic());
  }
}

