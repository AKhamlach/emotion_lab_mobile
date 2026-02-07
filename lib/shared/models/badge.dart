import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum BadgeCategory {
  onboarding('Onboarding'),
  streak('Streaks'),
  social('Social'),
  engagement('Engagement'),
  milestone('Milestone');

  const BadgeCategory(this.label);
  final String label;
}

class AppBadge extends Equatable {
  const AppBadge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    this.isEarned = false,
    this.earnedAt,
  });

  final String id;
  final String name;
  final String description;
  final IconData icon;
  final BadgeCategory category;
  final bool isEarned;
  final DateTime? earnedAt;

  AppBadge copyWith({
    String? id,
    String? name,
    String? description,
    IconData? icon,
    BadgeCategory? category,
    bool? isEarned,
    DateTime? earnedAt,
  }) {
    return AppBadge(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      isEarned: isEarned ?? this.isEarned,
      earnedAt: earnedAt ?? this.earnedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        icon,
        category,
        isEarned,
        earnedAt,
      ];
}
