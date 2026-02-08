import 'package:uuid/uuid.dart';

import '../../../../shared/mock_data/mock_messages.dart';
import '../../../../shared/models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  final List<ChatMessage> _messages = [];
  final _uuid = const Uuid();

  static const _distressKeywords = [
    'suicide',
    'kill myself',
    'end it all',
    'want to die',
    'self-harm',
    'hurt myself',
    'no reason to live',
    'hopeless',
    'give up on life',
    'can\'t go on',
  ];

  static const _aiResponses = [
    "That's a really thoughtful observation. Tell me more about how that makes you feel.",
    "I hear you. It sounds like you're going through a lot right now. What would feel most supportive?",
    "Thank you for sharing that with me. It takes courage to open up. How long have you been feeling this way?",
    "That's completely valid. Everyone experiences emotions differently. What usually helps you when you feel like this?",
    "I appreciate you trusting me with that. Let's explore that feeling together — what do you think triggered it?",
    "It sounds like you're being really self-aware, which is a great strength. What small step could you take today?",
    "I understand. Remember, it's okay to not have all the answers right now. What matters is that you're reflecting on it.",
    "That resonates with a lot of people. You're not alone in feeling this way. Would you like to try a quick grounding exercise?",
  ];

  static const _distressResponse =
      "I can sense you might be going through a really difficult time. "
      "Please know that you're not alone, and help is available. "
      "Would you like me to show you some support resources?";

  int _responseIndex = 0;

  @override
  Future<List<ChatMessage>> getMessageHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (_messages.isEmpty) {
      _messages.addAll(mockMessages);
    }
    return List.unmodifiable(_messages);
  }

  @override
  Future<ChatMessage> sendMessage(String content) async {
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      content: content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );
    _messages.add(userMessage);

    // Simulate AI thinking delay
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    final isDistress = detectDistress(content);
    final responseContent =
        isDistress ? _distressResponse : _aiResponses[_responseIndex];

    if (!isDistress) {
      _responseIndex = (_responseIndex + 1) % _aiResponses.length;
    }

    final aiMessage = ChatMessage(
      id: _uuid.v4(),
      content: responseContent,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      isDistressDetected: isDistress,
    );
    _messages.add(aiMessage);

    return aiMessage;
  }

  @override
  Future<void> clearHistory() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _messages.clear();
  }

  @override
  bool detectDistress(String content) {
    final lower = content.toLowerCase();
    return _distressKeywords.any((keyword) => lower.contains(keyword));
  }
}
