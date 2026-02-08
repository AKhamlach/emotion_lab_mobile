import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../../shared/models/chat_message.dart';
import '../data/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(const ChatInitial()) {
    on<ChatLoadRequested>(_onLoadRequested);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatCleared>(_onCleared);
  }

  final ChatRepository _chatRepository;

  Future<void> _onLoadRequested(
    ChatLoadRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());
    try {
      final messages = await _chatRepository.getMessageHistory();
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(ErrorHandler.userMessage(e)));
    }
  }

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final current = state;
    if (current is! ChatLoaded) return;

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: event.content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    final distress = _chatRepository.detectDistress(event.content);

    // Add user message and show typing indicator
    emit(current.copyWith(
      messages: [...current.messages, userMessage],
      isAiTyping: true,
      distressDetected: distress || current.distressDetected,
    ));

    try {
      final aiMessage = await _chatRepository.sendMessage(event.content);
      final updated = state;
      if (updated is! ChatLoaded) return;

      emit(updated.copyWith(
        messages: [...updated.messages, aiMessage],
        isAiTyping: false,
      ));
    } catch (e) {
      final updated = state;
      if (updated is! ChatLoaded) return;

      emit(updated.copyWith(isAiTyping: false));
    }
  }

  Future<void> _onCleared(
    ChatCleared event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.clearHistory();
      emit(const ChatLoaded(messages: []));
    } catch (_) {
      // Keep current state on clear failure
    }
  }
}
