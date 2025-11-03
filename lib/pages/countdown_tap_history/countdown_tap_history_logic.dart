import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:countdown_tap/db_countdown_tap/data.dart';
import 'package:countdown_tap/db_countdown_tap/db_countdown_tap_entity.dart';
import 'package:countdown_tap/utils/index.dart';

class CountdownTapHistoryLogic extends GetxController {
  final CountdownTapDatabase _database = Get.find<CountdownTapDatabase>();

  final matchHistory = <MatchHistoryEntity>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMatchHistory();
  }

  Future<void> loadMatchHistory() async {
    try {
      isLoading.value = true;

      final history = await _database.getMatchHistory();
      matchHistory.value = history;
    } catch (e) {
      errorToast('Failed to load match history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<MatchHistoryEntity>> get groupedMatchHistory {
    final Map<String, List<MatchHistoryEntity>> grouped = {};

    for (final match in matchHistory) {
      final dateGroup = _getDateGroup(match.timestamp);
      if (!grouped.containsKey(dateGroup)) {
        grouped[dateGroup] = [];
      }
      grouped[dateGroup]!.add(match);
    }

    return grouped;
  }

  String _getDateGroup(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final matchDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      if (matchDate == today) {
        return 'Today';
      } else if (matchDate == yesterday) {
        return 'Yesterday';
      } else {
        return DateFormat('MM/dd').format(dateTime);
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  String formatTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat('HH:mm').format(dateTime);
    } catch (e) {
      return '--:--';
    }
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> refreshHistory() async {
    await loadMatchHistory();
  }
}
