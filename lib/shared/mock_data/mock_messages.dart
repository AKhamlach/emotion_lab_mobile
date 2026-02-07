import '../models/chat_message.dart';

final mockMessages = <ChatMessage>[
  ChatMessage(
    id: 'msg1',
    content:
        "Hi there! I'm your Emotion Lab companion. How are you feeling today?",
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
  ),
  ChatMessage(
    id: 'msg2',
    content: "I've been feeling a bit stressed about my exams this week.",
    sender: MessageSender.user,
    timestamp: DateTime.now().subtract(const Duration(minutes: 11)),
  ),
  ChatMessage(
    id: 'msg3',
    content:
        "That's completely understandable — exam periods can be really intense. "
        "It sounds like you're carrying a lot right now. "
        "What subject is weighing on you the most?",
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ChatMessage(
    id: 'msg4',
    content: "Mostly math. I just can't seem to get the concepts to stick.",
    sender: MessageSender.user,
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
  ),
  ChatMessage(
    id: 'msg5',
    content:
        "Learning math can feel frustrating when things don't click right away. "
        "Have you tried breaking the material into smaller pieces? "
        "Sometimes tackling one concept at a time can make it less overwhelming.",
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  ChatMessage(
    id: 'msg6',
    content: "That's a good idea. I usually try to study everything at once.",
    sender: MessageSender.user,
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ChatMessage(
    id: 'msg7',
    content:
        "Taking smaller steps is a great strategy! Remember to also take "
        "breaks — your brain needs rest to absorb new information. "
        "You've got this!",
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
  ),
  ChatMessage(
    id: 'msg8',
    content: "Thanks, that actually makes me feel a little better.",
    sender: MessageSender.user,
    timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
  ),
];
