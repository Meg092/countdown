import 'package:countdown_tap/pages/countdown_tap_game/countdown_tap_game_binding.dart';
import 'package:countdown_tap/pages/countdown_tap_game/countdown_tap_game_view.dart';
import 'package:countdown_tap/pages/countdown_tap_history/countdown_tap_history_binding.dart';
import 'package:countdown_tap/pages/countdown_tap_history/countdown_tap_history_view.dart';
import 'package:countdown_tap/pages/countdown_tap_settings/countdown_tap_settings_binding.dart';
import 'package:countdown_tap/pages/countdown_tap_settings/countdown_tap_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:countdown_tap/db_countdown_tap/data.dart';
import 'package:countdown_tap/utils/index.dart';

Color primaryColor = const Color(0xFF3B82F6);
Color bgColor = const Color(0xFFF3F4F6);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();

  final database = CountdownTapDatabase();
  await database.init();
  Get.put(database);

  final settingsService = SettingsService();
  await settingsService.init();
  Get.put(settingsService);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: Tap,
          initialRoute: '/countdown_tap_game',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              surface: const Color(0xFFFFFFFF),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
List<GetPage<dynamic>> Tap = [
  GetPage(
    name: '/countdown_tap_game',
    page: () => const CountdownTapGameView(),
    binding: CountdownTapGameBinding(),
    transition: Transition.cupertino,
    popGesture: true,
    preventDuplicates: false,
  ),
  GetPage(
    name: '/countdown_tap_settings',
    page: () => const CountdownTapSettingsView(),
    binding: CountdownTapSettingsBinding(),
    transition: Transition.cupertino,
    popGesture: true,
    preventDuplicates: false,
  ),
  GetPage(
    name: '/countdown_tap_history',
    page: () => const CountdownTapHistoryView(),
    binding: CountdownTapHistoryBinding(),
    transition: Transition.cupertino,
    popGesture: true,
    preventDuplicates: false,
  ),
];