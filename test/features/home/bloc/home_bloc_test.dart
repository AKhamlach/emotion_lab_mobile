import 'package:bloc_test/bloc_test.dart';
import 'package:emotion_lab_mobile/features/home/bloc/home_bloc.dart';
import 'package:emotion_lab_mobile/features/home/data/repositories/home_repository.dart';
import 'package:emotion_lab_mobile/shared/models/gamification_stats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockRepo;

  const testStats = GamificationStats(
    points: 240,
    streak: 5,
    level: 3,
    levelProgress: 0.48,
  );

  setUp(() {
    mockRepo = MockHomeRepository();
  });

  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      'initial state is HomeInitial',
      build: () => HomeBloc(homeRepository: mockRepo),
      verify: (bloc) => expect(bloc.state, const HomeInitial()),
    );

    group('HomeLoadRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits HomeLoading then HomeLoaded on success',
        build: () {
          when(() => mockRepo.getGamificationStats())
              .thenAnswer((_) async => testStats);
          when(() => mockRepo.getTodayMood()).thenAnswer((_) async => null);
          return HomeBloc(homeRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect: () => [
          const HomeLoading(),
          const HomeLoaded(stats: testStats),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits HomeLoaded with existing mood',
        build: () {
          when(() => mockRepo.getGamificationStats())
              .thenAnswer((_) async => testStats);
          when(() => mockRepo.getTodayMood())
              .thenAnswer((_) async => 'Great');
          return HomeBloc(homeRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect: () => [
          const HomeLoading(),
          const HomeLoaded(stats: testStats, todayMood: 'Great'),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'emits HomeLoading then HomeError on failure',
        build: () {
          when(() => mockRepo.getGamificationStats())
              .thenThrow(Exception('Network error'));
          when(() => mockRepo.getTodayMood()).thenAnswer((_) async => null);
          return HomeBloc(homeRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const HomeLoadRequested()),
        expect: () => [
          const HomeLoading(),
          const HomeError('Something went wrong. Please try again.'),
        ],
      );
    });

    group('MoodSelected', () {
      blocTest<HomeBloc, HomeState>(
        'updates mood in HomeLoaded state',
        build: () {
          when(() => mockRepo.setTodayMood(any()))
              .thenAnswer((_) async {});
          return HomeBloc(homeRepository: mockRepo);
        },
        seed: () => const HomeLoaded(stats: testStats),
        act: (bloc) => bloc.add(const MoodSelected('Good')),
        expect: () => [
          const HomeLoaded(stats: testStats, todayMood: 'Good'),
        ],
        verify: (_) {
          verify(() => mockRepo.setTodayMood('Good')).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'does nothing when not in HomeLoaded state',
        build: () => HomeBloc(homeRepository: mockRepo),
        act: (bloc) => bloc.add(const MoodSelected('Good')),
        expect: () => <HomeState>[],
      );

      blocTest<HomeBloc, HomeState>(
        'keeps current state on mood save failure',
        build: () {
          when(() => mockRepo.setTodayMood(any()))
              .thenThrow(Exception('Save failed'));
          return HomeBloc(homeRepository: mockRepo);
        },
        seed: () => const HomeLoaded(stats: testStats, todayMood: 'Okay'),
        act: (bloc) => bloc.add(const MoodSelected('Bad')),
        expect: () => <HomeState>[],
        verify: (bloc) {
          expect(bloc.state, const HomeLoaded(stats: testStats, todayMood: 'Okay'));
        },
      );
    });
  });
}
