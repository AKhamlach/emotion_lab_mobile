part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

final class ChatLoadRequested extends ChatEvent {
  const ChatLoadRequested();
}

final class ChatMessageSent extends ChatEvent {
  const ChatMessageSent(this.content);

  final String content;

  @override
  List<Object?> get props => [content];
}

final class ChatCleared extends ChatEvent {
  const ChatCleared();
}
