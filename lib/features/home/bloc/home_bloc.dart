import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../../shared/models/gamification_stats.dart';
import '../data/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomeInitial()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<MoodSelected>(_onMoodSelected);
  }

  final HomeRepository _homeRepository;

  Future<void> _onLoadRequested(
    HomeLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        _homeRepository.getGamificationStats(),
        _homeRepository.getTodayMood(),
      ]);
      emit(HomeLoaded(
        stats: results[0] as GamificationStats,
        todayMood: results[1] as String?,
      ));
    } catch (e) {
      emit(HomeError(ErrorHandler.userMessage(e)));
    }
  }

  Future<void> _onMoodSelected(
    MoodSelected event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;
    if (current is! HomeLoaded) return;

    try {
      await _homeRepository.setTodayMood(event.mood);
      emit(current.copyWith(todayMood: event.mood));
    } catch (_) {
      // Keep current state — no emit needed, BLoC retains last state
    }
  }
}
