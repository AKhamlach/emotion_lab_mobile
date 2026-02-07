abstract final class DistressDetector {
  static const List<String> _keywords = [
    'kill myself',
    'end my life',
    'want to die',
    'suicide',
    'suicidal',
    'self-harm',
    'self harm',
    'hurt myself',
    'don\'t want to live',
    "don't want to live",
    'no reason to live',
    'better off dead',
    'can\'t go on',
    "can't go on",
    'give up on life',
    'ending it all',
    'not worth living',
    'overdose',
    'cut myself',
    'cutting myself',
  ];

  /// Returns `true` if [text] contains any distress-related keywords.
  ///
  /// Matching is case-insensitive and checks for substring presence.
  static bool containsDistressKeywords(String text) {
    if (text.isEmpty) return false;
    final lowerText = text.toLowerCase();
    return _keywords.any((keyword) => lowerText.contains(keyword));
  }
}
