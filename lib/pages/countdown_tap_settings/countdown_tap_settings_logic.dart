import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countdown_tap/utils/index.dart';

class CountdownTapSettingsLogic extends GetxController {
  final SettingsService _settingsService = Get.find<SettingsService>();

  final List<TimerOption> timerOptions = [
    TimerOption(label: '1 Min', seconds: 60),
    TimerOption(label: '3 Mins', seconds: 180),
    TimerOption(label: '5 Mins', seconds: 300),
    TimerOption(label: '10 Mins', seconds: 600),
    TimerOption(label: '15 Mins', seconds: 900),
    TimerOption(label: 'Custom', seconds: -1),
  ];

  int get selectedTimerDuration => _settingsService.timerDuration.value;

  int get selectedThemeIndex => _settingsService.themeIndex.value;

  String get player1Name => _settingsService.player1Name.value;

  String get player2Name => _settingsService.player2Name.value;

  bool isTimerDurationSelected(int seconds) {
    if (seconds == -1) {
      return !timerOptions
          .where((opt) => opt.seconds != -1)
          .any((opt) => opt.seconds == selectedTimerDuration);
    }
    return selectedTimerDuration == seconds;
  }

  Future<void> onTimerOptionTap(TimerOption option) async {
    try {
      if (option.seconds == -1) {
        await _showCustomTimerDialog();
      } else {
        await _settingsService.setTimerDuration(option.seconds);
        successToast('Timer duration set to ${option.label}');
      }
    } catch (e) {
      errorToast('Failed to set timer duration: $e');
    }
  }

  Future<void> _showCustomTimerDialog() async {
    final controller = TextEditingController();

    await Get.dialog(
      AlertDialog(
        title: const Text('Custom Timer'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Minutes (1-99)',
            hintText: 'Enter minutes',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final text = controller.text.trim();
              if (text.isEmpty) {
                errorToast('Please enter a valid number');
                return;
              }

              final minutes = int.tryParse(text);
              if (minutes == null || minutes < 1 || minutes > 99) {
                errorToast('Please enter a number between 1 and 99');
                return;
              }

              try {
                await _settingsService.setTimerDuration(minutes * 60);
                Get.back();
                successToast(
                  'Timer duration set to $minutes minute${minutes > 1 ? 's' : ''}',
                );
              } catch (e) {
                errorToast('Failed to set timer duration: $e');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> onThemeOptionTap(int index) async {
    try {
      await _settingsService.setThemeIndex(index);
      successToast('Theme changed');
    } catch (e) {
      errorToast('Failed to change theme: $e');
    }
  }

  Future<void> onPlayer1NameTap() async {
    await _showPlayerNameDialog(
      title: 'Player 1 Name',
      currentName: player1Name,
      onSave: (name) async {
        try {
          await _settingsService.setPlayer1Name(name);
          successToast('Player 1 name updated');
        } catch (e) {
          errorToast('Failed to update player 1 name: $e');
        }
      },
    );
  }

  Future<void> onPlayer2NameTap() async {
    await _showPlayerNameDialog(
      title: 'Player 2 Name',
      currentName: player2Name,
      onSave: (name) async {
        try {
          await _settingsService.setPlayer2Name(name);
          successToast('Player 2 name updated');
        } catch (e) {
          errorToast('Failed to update player 2 name: $e');
        }
      },
    );
  }

  Future<void> _showPlayerNameDialog({
    required String title,
    required String currentName,
    required Future<void> Function(String) onSave,
  }) async {
    final controller = TextEditingController(text: currentName);

    await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter player name',
          ),
          maxLength: 12,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) {
                errorToast('Name cannot be empty');
                return;
              }

              await onSave(name);
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void onMatchHistoryTap() {
    Get.toNamed('/countdown_tap_history');
  }
}

class TimerOption {
  final String label;
  final int seconds;

  TimerOption({required this.label, required this.seconds});
}
