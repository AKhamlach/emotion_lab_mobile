import '../models/auth_user.dart';
import '../models/gamification_stats.dart';
import '../models/user_profile.dart';
import 'mock_badges.dart';

final mockAuthUser = AuthUser(
  id: 'user-001',
  email: 'demo@emotionlab.app',
  pseudonym: 'Bright Panda',
  createdAt: DateTime.now().subtract(const Duration(days: 7)),
  isEmailVerified: true,
);

const mockUserProfile = UserProfile(
  pseudonym: 'Bright Panda',
  personalityTraits: {
    'social_energy': 'introvert',
    'approach': 'planner',
    'strengths': 'creative_thinker,empathetic_listener',
    'openness': 'moderate',
  },
  workHabits: {
    'schedule': 'flexible',
    'collaboration': 'small_team',
    'struggles': 'procrastination,perfectionism',
    'work_life_balance': 'moderate',
  },
  stressTriggers: {
    'primary': 'deadlines',
    'coping': 'break_or_walk',
    'recent_symptoms': 'trouble_sleeping,loss_of_motivation',
    'stress_management': 'moderate',
  },
  isOnboardingComplete: true,
);

final mockGamificationStats = GamificationStats(
  points: 240,
  streak: 5,
  level: 3,
  levelProgress: 0.48,
  earnedBadges: mockBadges.where((b) => b.isEarned).toList(),
);
