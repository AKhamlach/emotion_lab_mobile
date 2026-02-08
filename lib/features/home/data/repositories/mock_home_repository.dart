import '../../../../shared/mock_data/mock_user_profile.dart';
import '../../../../shared/models/gamification_stats.dart';
import 'home_repository.dart';

class MockHomeRepository implements HomeRepository {
  String? _todayMood;

  @override
  Future<GamificationStats> getGamificationStats() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return mockGamificationStats;
  }

  @override
  Future<String?> getTodayMood() async {
    return _todayMood;
  }

  @override
  Future<void> setTodayMood(String mood) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _todayMood = mood;
  }
}
