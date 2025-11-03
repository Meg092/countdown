import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxService {
  late final GetStorage _storage;

  static const String _keyTimerDuration = 'timer_duration';
  static const String _keyThemeIndex = 'theme_index';
  static const String _keyPlayer1Name = 'player1_name';
  static const String _keyPlayer2Name = 'player2_name';
  static const String _keyHapticFeedback = 'haptic_feedback';

  static const int defaultTimerDuration = 300;
  static const int defaultThemeIndex = 0;
  static const String defaultPlayer1Name = 'Player 1';
  static const String defaultPlayer2Name = 'Player 2';
  static const bool defaultHapticFeedback = true;

  final timerDuration = defaultTimerDuration.obs;
  final themeIndex = defaultThemeIndex.obs;
  final player1Name = defaultPlayer1Name.obs;
  final player2Name = defaultPlayer2Name.obs;
  final hapticFeedback = defaultHapticFeedback.obs;

  Future<SettingsService> init() async {
    _storage = GetStorage();
    await _loadSettings();
    return this;
  }

  Future<void> _loadSettings() async {
    timerDuration.value =
        _storage.read(_keyTimerDuration) ?? defaultTimerDuration;
    themeIndex.value = _storage.read(_keyThemeIndex) ?? defaultThemeIndex;
    player1Name.value = _storage.read(_keyPlayer1Name) ?? defaultPlayer1Name;
    player2Name.value = _storage.read(_keyPlayer2Name) ?? defaultPlayer2Name;
    hapticFeedback.value =
        _storage.read(_keyHapticFeedback) ?? defaultHapticFeedback;
  }

  Future<void> setTimerDuration(int seconds) async {
    try {
      await _storage.write(_keyTimerDuration, seconds);
      timerDuration.value = seconds;
    } catch (e) {
      throw Exception('Failed to save timer duration: $e');
    }
  }

  Future<void> setThemeIndex(int index) async {
    try {
      await _storage.write(_keyThemeIndex, index);
      themeIndex.value = index;
    } catch (e) {
      throw Exception('Failed to save theme index: $e');
    }
  }

  Future<void> setPlayer1Name(String name) async {
    try {
      final trimmedName = name.trim();
      if (trimmedName.isEmpty) {
        throw Exception('Player name cannot be empty');
      }
      await _storage.write(_keyPlayer1Name, trimmedName);
      player1Name.value = trimmedName;
    } catch (e) {
      throw Exception('Failed to save player 1 name: $e');
    }
  }

  Future<void> setPlayer2Name(String name) async {
    try {
      final trimmedName = name.trim();
      if (trimmedName.isEmpty) {
        throw Exception('Player name cannot be empty');
      }
      await _storage.write(_keyPlayer2Name, trimmedName);
      player2Name.value = trimmedName;
    } catch (e) {
      throw Exception('Failed to save player 2 name: $e');
    }
  }

  Future<void> setHapticFeedback(bool enabled) async {
    try {
      await _storage.write(_keyHapticFeedback, enabled);
      hapticFeedback.value = enabled;
    } catch (e) {
      throw Exception('Failed to save haptic feedback setting: $e');
    }
  }
}
