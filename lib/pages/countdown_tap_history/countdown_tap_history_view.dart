import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:countdown_tap/db_countdown_tap/db_countdown_tap_entity.dart';
import 'countdown_tap_history_logic.dart';

class CountdownTapHistoryView extends GetView<CountdownTapHistoryLogic> {
  const CountdownTapHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match History',
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
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.matchHistory.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: controller.refreshHistory,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(children: _buildHistorySections()),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildHistorySections() {
    final grouped = controller.groupedMatchHistory;
    final List<Widget> sections = [];

    final sortedKeys =
        grouped.keys.toList()..sort((a, b) {
          if (a == 'Today') return -1;
          if (b == 'Today') return 1;
          if (a == 'Yesterday') return -1;
          if (b == 'Yesterday') return 1;
          return b.compareTo(a);
        });

    for (var i = 0; i < sortedKeys.length; i++) {
      final dateGroup = sortedKeys[i];
      final matches = grouped[dateGroup]!;

      sections.add(_buildDateSection(dateGroup, matches));

      if (i < sortedKeys.length - 1) {
        sections.add(SizedBox(height: 20.h));
      }
    }

    sections.add(SizedBox(height: 40.h));
    return sections;
  }

  Widget _buildDateSection(String date, List<MatchHistoryEntity> matches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date.toUpperCase(),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B7280),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.h),
        ...matches.asMap().entries.map((entry) {
          final match = entry.value;
          return Column(
            children: [
              _buildHistoryCard(match),
              if (entry.key < matches.length - 1) SizedBox(height: 10.h),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildHistoryCard(MatchHistoryEntity match) {
    int winner = 0;
    if (match.isPlayer1Winner) {
      winner = 1;
    } else if (match.isPlayer2Winner) {
      winner = 2;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.formatTime(match.timestamp),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 13.sp,
                      color: const Color(0xFF6B7280),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      controller.formatDuration(match.duration),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: _buildPlayerResult(
                  match.player1Name,
                  match.player1Score.toString(),
                  winner == 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              Expanded(
                child: _buildPlayerResult(
                  match.player2Name,
                  match.player2Score.toString(),
                  winner == 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerResult(String name, String score, bool isWinner) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        Text(
          score,
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF111827),
          ),
        ),
        if (isWinner)
          Container(
            margin: EdgeInsets.only(top: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 11.sp, color: Colors.white),
                SizedBox(width: 5.w),
                Text(
                  'Winner',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80.sp, color: const Color(0xFFD1D5DB)),
          SizedBox(height: 20.h),
          Text(
            'No matches yet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start playing to see your match history',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}
