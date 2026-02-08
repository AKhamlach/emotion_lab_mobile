part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.stats,
    this.todayMood,
  });

  final GamificationStats stats;
  final String? todayMood;

  bool get hasMoodToday => todayMood != null;

  HomeLoaded copyWith({
    GamificationStats? stats,
    String? todayMood,
  }) {
    return HomeLoaded(
      stats: stats ?? this.stats,
      todayMood: todayMood ?? this.todayMood,
    );
  }

  @override
  List<Object?> get props => [stats, todayMood];
}

final class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
