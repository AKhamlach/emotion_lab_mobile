import '../../../../shared/models/gamification_stats.dart';

/// Abstract contract for home screen data.
abstract class HomeRepository {
  Future<GamificationStats> getGamificationStats();

  Future<String?> getTodayMood();

  Future<void> setTodayMood(String mood);
}
