import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../shared/models/chat_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    super.key,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final colors = context.appColors;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: context.screenWidth * 0.75,
        ),
        margin: EdgeInsets.only(
          left: isUser ? AppDimensions.spacing48 : 0,
          right: isUser ? 0 : AppDimensions.spacing48,
          bottom: AppDimensions.spacing8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing16,
          vertical: AppDimensions.spacing12,
        ),
        decoration: BoxDecoration(
          color: isUser ? colors.chatBubbleUser : colors.chatBubbleAi,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppDimensions.radiusLarge),
            topRight: const Radius.circular(AppDimensions.radiusLarge),
            bottomLeft: isUser
                ? const Radius.circular(AppDimensions.radiusLarge)
                : const Radius.circular(AppDimensions.radiusSmall),
            bottomRight: isUser
                ? const Radius.circular(AppDimensions.radiusSmall)
                : const Radius.circular(AppDimensions.radiusLarge),
          ),
        ),
        child: Text(
          message.content,
          style: context.textTheme.bodyMedium?.copyWith(
            color:
                isUser ? colors.onChatBubbleUser : colors.onChatBubbleAi,
          ),
        ),
      ),
    );
  }
}
