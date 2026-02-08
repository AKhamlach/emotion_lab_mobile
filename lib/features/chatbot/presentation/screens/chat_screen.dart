import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../bloc/chat_bloc.dart';
import '../widgets/chat_disclaimer_banner.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/clear_chat_button.dart';
import '../widgets/distress_alert_overlay.dart';
import '../widgets/message_list.dart';
import '../widgets/quick_replies_row.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _showDistressAlert = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const ChatLoadRequested());
  }

  void _sendMessage(String content) {
    context.read<ChatBloc>().add(ChatMessageSent(content));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          ClearChatButton(
            onPressed: () =>
                context.read<ChatBloc>().add(const ChatCleared()),
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded && state.distressDetected) {
            setState(() => _showDistressAlert = true);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading || state is ChatInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context
                        .read<ChatBloc>()
                        .add(const ChatLoadRequested()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final loaded = state as ChatLoaded;
          final hasMessages = loaded.messages.isNotEmpty;

          return Column(
            children: [
              const ChatDisclaimerBanner(),
              if (_showDistressAlert)
                DistressAlertOverlay(
                  onDismiss: () =>
                      setState(() => _showDistressAlert = false),
                  onEmergencyTap: () =>
                      context.pushNamed(RouteNames.emergency),
                ),
              Expanded(
                child: hasMessages
                    ? MessageList(
                        messages: loaded.messages,
                        isAiTyping: loaded.isAiTyping,
                      )
                    : const Center(
                        child: Text('Start a conversation!'),
                      ),
              ),
              if (!hasMessages && !loaded.isAiTyping)
                QuickRepliesRow(onReplySelected: _sendMessage),
              ChatInputBar(
                onSend: _sendMessage,
                enabled: !loaded.isAiTyping,
              ),
            ],
          );
        },
      ),
    );
  }
}
