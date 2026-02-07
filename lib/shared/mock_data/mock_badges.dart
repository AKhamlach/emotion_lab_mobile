import 'package:flutter/material.dart';

import '../models/badge.dart';

final mockBadges = <AppBadge>[
  // ─── Earned ───
  AppBadge(
    id: 'b1',
    name: 'First Steps',
    description: 'Complete the onboarding questionnaire.',
    icon: Icons.emoji_events,
    category: BadgeCategory.onboarding,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
  AppBadge(
    id: 'b2',
    name: 'Conversation Starter',
    description: 'Send your first message to the AI companion.',
    icon: Icons.chat_bubble_outline,
    category: BadgeCategory.engagement,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 6)),
  ),
  AppBadge(
    id: 'b3',
    name: 'Three-Day Streak',
    description: 'Check in for 3 days in a row.',
    icon: Icons.local_fire_department,
    category: BadgeCategory.streak,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 4)),
  ),
  AppBadge(
    id: 'b4',
    name: 'Buddy Up',
    description: 'Connect with your first motivational buddy.',
    icon: Icons.people_outline,
    category: BadgeCategory.social,
    isEarned: true,
    earnedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),

  // ─── Locked ───
  const AppBadge(
    id: 'b5',
    name: 'Week Warrior',
    description: 'Maintain a 7-day check-in streak.',
    icon: Icons.calendar_month,
    category: BadgeCategory.streak,
  ),
  const AppBadge(
    id: 'b6',
    name: 'Deep Thinker',
    description: 'Have 20 conversations with the AI companion.',
    icon: Icons.psychology,
    category: BadgeCategory.engagement,
  ),
  const AppBadge(
    id: 'b7',
    name: 'Support Star',
    description: 'Exchange 50 messages with a buddy.',
    icon: Icons.star_outline,
    category: BadgeCategory.social,
  ),
  const AppBadge(
    id: 'b8',
    name: 'Month Master',
    description: 'Maintain a 30-day check-in streak.',
    icon: Icons.military_tech,
    category: BadgeCategory.milestone,
  ),
  const AppBadge(
    id: 'b9',
    name: 'Explorer',
    description: 'Visit every section of the app.',
    icon: Icons.explore_outlined,
    category: BadgeCategory.engagement,
  ),
  const AppBadge(
    id: 'b10',
    name: 'Centurion',
    description: 'Earn 100 total points.',
    icon: Icons.workspace_premium,
    category: BadgeCategory.milestone,
  ),
];
