import '../../../../shared/models/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessageHistory();

  Future<ChatMessage> sendMessage(String content);

  Future<void> clearHistory();

  bool detectDistress(String content);
}
