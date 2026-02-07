import '../models/buddy_profile.dart';

const mockBuddies = <BuddyProfile>[
  BuddyProfile(
    id: 'buddy1',
    pseudonym: 'Calm Otter',
    compatibilityScore: 0.87,
    sharedTraits: ['Creative thinker', 'Night owl', 'Empathetic listener'],
    status: BuddyStatus.available,
  ),
  BuddyProfile(
    id: 'buddy2',
    pseudonym: 'Brave Fox',
    compatibilityScore: 0.62,
    sharedTraits: ['Detail-oriented', 'Flexible schedule'],
    status: BuddyStatus.connected,
  ),
  BuddyProfile(
    id: 'buddy3',
    pseudonym: 'Gentle Owl',
    compatibilityScore: 0.45,
    sharedTraits: ['Analytical', 'Solo worker'],
    status: BuddyStatus.available,
  ),
];
