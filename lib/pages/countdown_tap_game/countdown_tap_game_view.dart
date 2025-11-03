import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:countdown_tap/utils/theme_config.dart';
import 'countdown_tap_game_logic.dart';

class CountdownTapGameView extends GetView<CountdownTapGameLogic> {
  const CountdownTapGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildPlayer1Area(context),
          _buildPlayer2Area(),
          _buildCenterControl(),
        ],
      ),
    );
  }

  Widget _buildPlayButtonWithFeedback() {
    return _PlayButtonWithFeedback(controller: controller);
  }

  Widget _buildPlayer1Area(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: Get.height / 2,
      child: Transform.rotate(
        angle: 3.14159,
        child: Obx(() {
          final theme = ThemeConfig.getTheme(controller.themeIndex);

          return GestureDetector(
            onTapUp: (details) {
              final localPosition = details.localPosition;
              controller.onPlayer1Tap(localPosition);
            },
            child: Container(
              decoration: BoxDecoration(gradient: theme.player1Gradient),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: topPadding),
                      Text(
                        controller.player1Name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        controller.formattedTime,
                        style: TextStyle(
                          fontSize: 96.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Score: ',
                            style: TextStyle(
                              fontSize: 48.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${controller.player1Score.value}',
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'TAP TO SCORE',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.5),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  ...controller.player1Animations.map((animation) {
                    return _buildScoreAnimation(animation);
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPlayer2Area() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: Get.height / 2,
      child: Obx(() {
        final theme = ThemeConfig.getTheme(controller.themeIndex);

        return GestureDetector(
          onTapUp: (details) {
            final localPosition = details.localPosition;
            controller.onPlayer2Tap(localPosition);
          },
          child: Container(
            decoration: BoxDecoration(gradient: theme.player2Gradient),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.player2Name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      controller.formattedTime,
                      style: TextStyle(
                        fontSize: 96.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Score: ',
                          style: TextStyle(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${controller.player2Score.value}',
                            style: TextStyle(
                              fontSize: 48.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'TAP TO SCORE',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                ...controller.player2Animations.map((animation) {
                  return _buildScoreAnimation(animation);
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScoreAnimation(ScoreAnimation animation) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, child) {
        return Positioned(
          left: animation.position.dx - 20,
          top: animation.position.dy - 80 * value,
          child: Opacity(
            opacity: 1 - value,
            child: Text(
              '+1',
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                shadows: [
                  Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCenterControl() {
    return Positioned(
      top: Get.height / 2 - 50.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton(
            icon: Icons.refresh,
            onTap: controller.onResetTap,
          ),
          SizedBox(width: 40.w),
          _buildPlayButtonWithFeedback(),
          SizedBox(width: 40.w),
          _buildControlButton(
            icon: Icons.settings,
            onTap: controller.onSettingsTap,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 24.sp, color: const Color(0xFF1F2937)),
      ),
    );
  }
}

class _PlayButtonWithFeedback extends StatefulWidget {
  final CountdownTapGameLogic controller;

  const _PlayButtonWithFeedback({required this.controller});

  @override
  State<_PlayButtonWithFeedback> createState() =>
      _PlayButtonWithFeedbackState();
}

class _PlayButtonWithFeedbackState extends State<_PlayButtonWithFeedback>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
    widget.controller.onPlayPauseTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Obx(() {
          final isPlaying = widget.controller.isPlaying.value;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    isPlaying
                        ? [const Color(0xFF1F2937), const Color(0xFF111827)]
                        : [const Color(0xFF059669), const Color(0xFF047857)],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.9),
                width: 5,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isPlaying ? Colors.black : const Color(0xFF059669))
                      .withOpacity(_isPressed ? 0.7 : 0.5),
                  blurRadius: _isPressed ? 40 : 30,
                  offset: Offset(0, _isPressed ? 4 : 8),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: RotationTransition(turns: animation, child: child),
                );
              },
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                key: ValueKey<bool>(isPlaying),
                size: 60.sp,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}
