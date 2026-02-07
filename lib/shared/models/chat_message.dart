import 'package:equatable/equatable.dart';

enum MessageSender {
  user,
  ai,
  system,
}

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isDistressDetected = false,
  });

  final String id;
  final String content;
  final MessageSender sender;
  final DateTime timestamp;
  final bool isDistressDetected;

  bool get isUser => sender == MessageSender.user;
  bool get isAi => sender == MessageSender.ai;

  ChatMessage copyWith({
    String? id,
    String? content,
    MessageSender? sender,
    DateTime? timestamp,
    bool? isDistressDetected,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      isDistressDetected: isDistressDetected ?? this.isDistressDetected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        content,
        sender,
        timestamp,
        isDistressDetected,
      ];
}
