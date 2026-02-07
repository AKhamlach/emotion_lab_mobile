import 'package:equatable/equatable.dart';

import 'badge.dart';

class GamificationStats extends Equatable {
  const GamificationStats({
    this.points = 0,
    this.streak = 0,
    this.level = 1,
    this.levelProgress = 0.0,
    this.earnedBadges = const [],
  });

  final int points;
  final int streak;
  final int level;

  /// Value between 0.0 and 1.0 representing progress to next level.
  final double levelProgress;
  final List<AppBadge> earnedBadges;

  int get totalBadges => earnedBadges.length;

  GamificationStats copyWith({
    int? points,
    int? streak,
    int? level,
    double? levelProgress,
    List<AppBadge>? earnedBadges,
  }) {
    return GamificationStats(
      points: points ?? this.points,
      streak: streak ?? this.streak,
      level: level ?? this.level,
      levelProgress: levelProgress ?? this.levelProgress,
      earnedBadges: earnedBadges ?? this.earnedBadges,
    );
  }

  @override
  List<Object?> get props => [
        points,
        streak,
        level,
        levelProgress,
        earnedBadges,
      ];
}
