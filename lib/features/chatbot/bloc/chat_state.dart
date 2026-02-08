part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatLoading extends ChatState {
  const ChatLoading();
}

final class ChatLoaded extends ChatState {
  const ChatLoaded({
    required this.messages,
    this.isAiTyping = false,
    this.distressDetected = false,
  });

  final List<ChatMessage> messages;
  final bool isAiTyping;
  final bool distressDetected;

  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isAiTyping,
    bool? distressDetected,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      distressDetected: distressDetected ?? this.distressDetected,
    );
  }

  @override
  List<Object?> get props => [messages, isAiTyping, distressDetected];
}

final class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
