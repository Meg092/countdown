import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:countdown_tap/utils/theme_config.dart';
import 'countdown_tap_settings_logic.dart';

class CountdownTapSettingsView extends GetView<CountdownTapSettingsLogic> {
  const CountdownTapSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  _buildTimerSection(),
                  SizedBox(height: 20.h),
                  _buildColorThemeSection(),
                  SizedBox(height: 20.h),
                  _buildPlayerSection(),
                  SizedBox(height: 20.h),
                  _buildGeneralSection(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'TIMER DURATION',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Obx(
              () => Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children:
                    controller.timerOptions.map((option) {
                      return _buildTimeOption(
                        option.label,
                        controller.isTimerDurationSelected(option.seconds),
                        () => controller.onTimerOptionTap(option),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOption(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildColorThemeSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'COLOR THEME',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Obx(() {
              final selectedIndex = controller.selectedThemeIndex;
              return GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(8, (index) {
                  final theme = ThemeConfig.getTheme(index);
                  final isSelected = selectedIndex == index;
                  return _buildColorOption(
                    theme.previewGradient,
                    isSelected,
                    () => controller.onThemeOptionTap(index),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(
    Gradient gradient,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(
            color: isActive ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        transform:
            isActive ? Matrix4.identity().scaled(1.05) : Matrix4.identity(),
        child: Center(
          child:
              isActive
                  ? Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 26.sp,
                    fontWeight: FontWeight.bold,
                  )
                  : const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildPlayerSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'PLAYER SETTINGS',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
          ),
          Obx(
            () => _buildSettingItem(
              icon: Icons.person,
              iconColor: const Color(0xFF3B82F6),
              title: 'Player 1 Name',
              subtitle: controller.player1Name,
              onTap: controller.onPlayer1NameTap,
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          Obx(
            () => _buildSettingItem(
              icon: Icons.person,
              iconColor: const Color(0xFFEF4444),
              title: 'Player 2 Name',
              subtitle: controller.player2Name,
              onTap: controller.onPlayer2NameTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          _buildSettingItem(
            icon: Icons.history,
            iconColor: const Color(0xFF6366F1),
            title: 'Match History',
            subtitle: null,
            onTap: controller.onMatchHistoryTap,
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          _buildSettingItem(
            icon: Icons.info_outline,
            iconColor: const Color(0xFF8B5CF6),
            title: 'Version',
            subtitle: 'v1.0.0',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [iconColor, iconColor.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(12.w),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                      letterSpacing: -0.3,
                    ),
                  ),

                  subtitle != null
                      ? Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          letterSpacing: -0.1,
                        ),
                      )
                      : Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
