import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../shared/models/chat_message.dart';
import 'chat_typing_indicator.dart';
import 'message_bubble.dart';

class MessageList extends StatefulWidget {
  const MessageList({
    required this.messages,
    this.isAiTyping = false,
    super.key,
  });

  final List<ChatMessage> messages;
  final bool isAiTyping;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant MessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length ||
        widget.isAiTyping != oldWidget.isAiTyping) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: AppDimensions.animNormal),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing16,
        vertical: AppDimensions.spacing8,
      ),
      itemCount: widget.messages.length + (widget.isAiTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.messages.length && widget.isAiTyping) {
          return const ChatTypingIndicator();
        }
        return MessageBubble(message: widget.messages[index]);
      },
    );
  }
}
