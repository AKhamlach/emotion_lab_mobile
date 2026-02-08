part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

final class MoodSelected extends HomeEvent {
  const MoodSelected(this.mood);

  final String mood;

  @override
  List<Object?> get props => [mood];
}
