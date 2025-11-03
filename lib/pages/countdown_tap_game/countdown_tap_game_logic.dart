import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:countdown_tap/db_countdown_tap/data.dart';
import 'package:countdown_tap/db_countdown_tap/db_countdown_tap_entity.dart';
import 'package:countdown_tap/utils/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountdownTapGameLogic extends GetxController {
  final SettingsService _settingsService = Get.find<SettingsService>();
  final CountdownTapDatabase _database = Get.find<CountdownTapDatabase>();

  final isPlaying = false.obs;
  final remainingSeconds = 0.obs;
  final player1Score = 0.obs;
  final player2Score = 0.obs;

  final player1Animations = <ScoreAnimation>[].obs;
  final player2Animations = <ScoreAnimation>[].obs;

  Timer? _timer;
  int _initialDuration = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeGame();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _initializeGame() {
    _initialDuration = _settingsService.timerDuration.value;
    remainingSeconds.value = _initialDuration;
  }

  void refreshSettings() {
    _pauseGame();
    _initialDuration = _settingsService.timerDuration.value;
    remainingSeconds.value = _initialDuration;
    player1Score.value = 0;
    player2Score.value = 0;
    player1Animations.clear();
    player2Animations.clear();
  }

  String get player1Name => _settingsService.player1Name.value;
  String get player2Name => _settingsService.player2Name.value;

  int get themeIndex => _settingsService.themeIndex.value;

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void onPlayPauseTap() {
    if (isPlaying.value) {
      _pauseGame();
    } else {
      _startGame();
    }
  }

  void _startGame() {
    if (remainingSeconds.value <= 0) {
      errorToast('Timer has ended. Please reset to start a new game.');
      return;
    }

    isPlaying.value = true;
    _triggerHaptic();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;

        if (remainingSeconds.value == 0) {
          _endGame();
        }
      }
    });
  }

  void _pauseGame() {
    isPlaying.value = false;
    _timer?.cancel();
    _triggerHaptic();
  }

  Future<void> _endGame() async {
    _pauseGame();
    await _saveGameRecord();
    Get.dialog(_buildGameOverDialog(), barrierDismissible: false);
  }

  Widget _buildGameOverDialog() {
    final p1Score = player1Score.value;
    final p2Score = player2Score.value;
    final isDraw = p1Score == p2Score;
    final winner = p1Score > p2Score ? player1Name : player2Name;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isDraw
                    ? [const Color(0xFF6B7280), const Color(0xFF4B5563)]
                    : [const Color(0xFF059669), const Color(0xFF047857)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(
                isDraw ? Icons.handshake : Icons.emoji_events,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isDraw ? 'Draw!' : 'Victory!',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            if (!isDraw) ...[
              Text(
                winner.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.95),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Wins!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ] else ...[
              Text(
                'It\'s a tie!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildScoreColumn(player1Name, p1Score, p1Score > p2Score),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: 2,
                    height: 40,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _buildScoreColumn(player2Name, p2Score, p2Score > p1Score),
                ],
              ),
            ),

            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: _buildDialogButton(
                    label: 'Close',
                    onTap: () => Get.back(),
                    isPrimary: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDialogButton(
                    label: 'New Game',
                    onTap: () {
                      Get.back();
                      _resetGame();
                    },
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreColumn(String name, int score, bool isWinner) {
    return Column(
      children: [
        Text(
          name.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWinner) const Icon(Icons.star, color: Colors.amber, size: 20),
            if (isWinner) const SizedBox(width: 4),
            Text(
              '$score',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 8),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDialogButton({
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border:
              isPrimary
                  ? null
                  : Border.all(color: Colors.white.withOpacity(0.4), width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPrimary ? const Color(0xFF047857) : Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Future<void> _saveGameRecord() async {
    try {
      final match = MatchHistoryEntity(
        timestamp: DateTime.now().toIso8601String(),
        duration: _initialDuration,
        player1Name: player1Name,
        player1Score: player1Score.value,
        player2Name: player2Name,
        player2Score: player2Score.value,
      );

      await _database.insertMatchHistory(match);
    } catch (e) {
    }
  }

  void onResetTap() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey.shade50],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.red.shade400],
                  ),
                ),
                child: Icon(
                  Icons.restart_alt_rounded,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Are you sure you want to reset?\nAll progress will be lost.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          colors: [Colors.orange.shade400, Colors.red.shade400],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          _resetGame();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void _resetGame() {
    _pauseGame();
    _initialDuration = _settingsService.timerDuration.value;
    remainingSeconds.value = _initialDuration;
    player1Score.value = 0;
    player2Score.value = 0;
    player1Animations.clear();
    player2Animations.clear();
    _triggerHaptic();
  }

  void onSettingsTap() {
    Get.toNamed('/countdown_tap_settings')?.then((_) {
      refreshSettings();
    });
  }

  void onPlayer1Tap(Offset position) {
    if (!isPlaying.value) return;

    player1Score.value++;
    _triggerHaptic();
    _addScoreAnimation(player1Animations, position);
  }

  void onPlayer2Tap(Offset position) {
    if (!isPlaying.value) return;

    player2Score.value++;
    _triggerHaptic();
    _addScoreAnimation(player2Animations, position);
  }

  void _addScoreAnimation(RxList<ScoreAnimation> animations, Offset position) {
    final animation = ScoreAnimation(
      id: DateTime.now().millisecondsSinceEpoch,
      position: position,
    );

    animations.add(animation);

    Future.delayed(const Duration(milliseconds: 800), () {
      animations.removeWhere((a) => a.id == animation.id);
    });
  }

  void _triggerHaptic() {
    if (_settingsService.hapticFeedback.value) {
      HapticFeedback.lightImpact();
    }
  }
}

class ScoreAnimation {
  final int id;
  final Offset position;

  ScoreAnimation({required this.id, required this.position});
}
