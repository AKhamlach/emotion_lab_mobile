import 'package:bloc_test/bloc_test.dart';
import 'package:emotion_lab_mobile/features/chatbot/bloc/chat_bloc.dart';
import 'package:emotion_lab_mobile/features/chatbot/data/repositories/chat_repository.dart';
import 'package:emotion_lab_mobile/shared/models/chat_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockRepo;

  final testMessages = [
    ChatMessage(
      id: 'msg1',
      content: 'Hello!',
      sender: MessageSender.ai,
      timestamp: DateTime(2024, 1, 1),
    ),
    ChatMessage(
      id: 'msg2',
      content: 'Hi there!',
      sender: MessageSender.user,
      timestamp: DateTime(2024, 1, 1, 0, 1),
    ),
  ];

  final aiResponse = ChatMessage(
    id: 'msg3',
    content: 'How are you feeling?',
    sender: MessageSender.ai,
    timestamp: DateTime(2024, 1, 1, 0, 2),
  );

  setUp(() {
    mockRepo = MockChatRepository();
  });

  group('ChatBloc', () {
    blocTest<ChatBloc, ChatState>(
      'initial state is ChatInitial',
      build: () => ChatBloc(chatRepository: mockRepo),
      verify: (bloc) => expect(bloc.state, const ChatInitial()),
    );

    group('ChatLoadRequested', () {
      blocTest<ChatBloc, ChatState>(
        'emits ChatLoading then ChatLoaded on success',
        build: () {
          when(() => mockRepo.getMessageHistory())
              .thenAnswer((_) async => testMessages);
          return ChatBloc(chatRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const ChatLoadRequested()),
        expect: () => [
          const ChatLoading(),
          ChatLoaded(messages: testMessages),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'emits ChatLoading then ChatError on failure',
        build: () {
          when(() => mockRepo.getMessageHistory())
              .thenThrow(Exception('Network error'));
          return ChatBloc(chatRepository: mockRepo);
        },
        act: (bloc) => bloc.add(const ChatLoadRequested()),
        expect: () => [
          const ChatLoading(),
          const ChatError('Something went wrong. Please try again.'),
        ],
      );
    });

    group('ChatMessageSent', () {
      blocTest<ChatBloc, ChatState>(
        'adds user message, shows typing, then adds AI response',
        build: () {
          when(() => mockRepo.detectDistress(any())).thenReturn(false);
          when(() => mockRepo.sendMessage(any()))
              .thenAnswer((_) async => aiResponse);
          return ChatBloc(chatRepository: mockRepo);
        },
        seed: () => ChatLoaded(messages: testMessages),
        act: (bloc) => bloc.add(const ChatMessageSent('How are you?')),
        expect: () => [
          isA<ChatLoaded>()
              .having((s) => s.messages.length, 'message count', 3)
              .having((s) => s.isAiTyping, 'isAiTyping', true)
              .having(
                  (s) => s.messages.last.content, 'user msg', 'How are you?'),
          isA<ChatLoaded>()
              .having((s) => s.messages.length, 'message count', 4)
              .having((s) => s.isAiTyping, 'isAiTyping', false)
              .having((s) => s.messages.last.content, 'ai msg',
                  'How are you feeling?'),
        ],
        verify: (_) {
          verify(() => mockRepo.sendMessage('How are you?')).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'sets distressDetected when distress keywords found',
        build: () {
          when(() => mockRepo.detectDistress(any())).thenReturn(true);
          when(() => mockRepo.sendMessage(any()))
              .thenAnswer((_) async => aiResponse);
          return ChatBloc(chatRepository: mockRepo);
        },
        seed: () => ChatLoaded(messages: testMessages),
        act: (bloc) =>
            bloc.add(const ChatMessageSent('I want to hurt myself')),
        expect: () => [
          isA<ChatLoaded>()
              .having((s) => s.distressDetected, 'distress', true)
              .having((s) => s.isAiTyping, 'isAiTyping', true),
          isA<ChatLoaded>()
              .having((s) => s.distressDetected, 'distress', true)
              .having((s) => s.isAiTyping, 'isAiTyping', false),
        ],
      );

      blocTest<ChatBloc, ChatState>(
        'does nothing when not in ChatLoaded state',
        build: () => ChatBloc(chatRepository: mockRepo),
        act: (bloc) => bloc.add(const ChatMessageSent('Hello')),
        expect: () => <ChatState>[],
      );

      blocTest<ChatBloc, ChatState>(
        'hides typing indicator on send failure',
        build: () {
          when(() => mockRepo.detectDistress(any())).thenReturn(false);
          when(() => mockRepo.sendMessage(any()))
              .thenThrow(Exception('Send failed'));
          return ChatBloc(chatRepository: mockRepo);
        },
        seed: () => ChatLoaded(messages: testMessages),
        act: (bloc) => bloc.add(const ChatMessageSent('Hello')),
        expect: () => [
          isA<ChatLoaded>()
              .having((s) => s.isAiTyping, 'isAiTyping', true),
          isA<ChatLoaded>()
              .having((s) => s.isAiTyping, 'isAiTyping', false),
        ],
      );
    });

    group('ChatCleared', () {
      blocTest<ChatBloc, ChatState>(
        'clears messages on success',
        build: () {
          when(() => mockRepo.clearHistory()).thenAnswer((_) async {});
          return ChatBloc(chatRepository: mockRepo);
        },
        seed: () => ChatLoaded(messages: testMessages),
        act: (bloc) => bloc.add(const ChatCleared()),
        expect: () => [
          const ChatLoaded(messages: []),
        ],
        verify: (_) {
          verify(() => mockRepo.clearHistory()).called(1);
        },
      );

      blocTest<ChatBloc, ChatState>(
        'keeps current state on clear failure',
        build: () {
          when(() => mockRepo.clearHistory())
              .thenThrow(Exception('Clear failed'));
          return ChatBloc(chatRepository: mockRepo);
        },
        seed: () => ChatLoaded(messages: testMessages),
        act: (bloc) => bloc.add(const ChatCleared()),
        expect: () => <ChatState>[],
        verify: (bloc) {
          final state = bloc.state as ChatLoaded;
          expect(state.messages, testMessages);
        },
      );
    });
  });
}
