import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../widgets/daily_mood_check.dart';
import '../widgets/greeting_header.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/safety_banner.dart';
import '../widgets/streak_summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final pseudonym = authState is Authenticated
        ? authState.user.pseudonym
        : 'Explorer';

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: AppDimensions.spacing16),
                    TextButton(
                      onPressed: () => context
                          .read<HomeBloc>()
                          .add(const HomeLoadRequested()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final loaded = state as HomeLoaded;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const HomeLoadRequested());
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacing16,
                  vertical: AppDimensions.spacing16,
                ),
                children: [
                  GreetingHeader(pseudonym: pseudonym),
                  const SizedBox(height: AppDimensions.spacing24),
                  DailyMoodCheck(
                    selectedMood: loaded.todayMood,
                    onMoodSelected: (mood) =>
                        context.read<HomeBloc>().add(MoodSelected(mood)),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                  StreakSummaryCard(stats: loaded.stats),
                  const SizedBox(height: AppDimensions.spacing24),
                  QuickActionsRow(
                    onChatTap: () => context.goNamed(RouteNames.chat),
                    onBuddyTap: () => context.goNamed(RouteNames.buddy),
                    onAchievementsTap: () =>
                        context.pushNamed(RouteNames.achievements),
                  ),
                  const SizedBox(height: AppDimensions.spacing24),
                  SafetyBanner(
                    onTap: () => context.pushNamed(RouteNames.emergency),
                  ),
                  const SizedBox(height: AppDimensions.spacing16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
