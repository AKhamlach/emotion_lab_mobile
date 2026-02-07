import 'package:equatable/equatable.dart';

enum BuddyStatus {
  available,
  pending,
  connected,
  blocked,
}

class BuddyProfile extends Equatable {
  const BuddyProfile({
    required this.id,
    required this.pseudonym,
    required this.compatibilityScore,
    this.sharedTraits = const [],
    this.status = BuddyStatus.available,
    this.isIdentityRevealed = false,
  });

  final String id;
  final String pseudonym;

  /// Value between 0.0 and 1.0.
  final double compatibilityScore;
  final List<String> sharedTraits;
  final BuddyStatus status;
  final bool isIdentityRevealed;

  BuddyProfile copyWith({
    String? id,
    String? pseudonym,
    double? compatibilityScore,
    List<String>? sharedTraits,
    BuddyStatus? status,
    bool? isIdentityRevealed,
  }) {
    return BuddyProfile(
      id: id ?? this.id,
      pseudonym: pseudonym ?? this.pseudonym,
      compatibilityScore: compatibilityScore ?? this.compatibilityScore,
      sharedTraits: sharedTraits ?? this.sharedTraits,
      status: status ?? this.status,
      isIdentityRevealed: isIdentityRevealed ?? this.isIdentityRevealed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        pseudonym,
        compatibilityScore,
        sharedTraits,
        status,
        isIdentityRevealed,
      ];
}
