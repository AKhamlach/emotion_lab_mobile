import 'package:flutter/material.dart';

class ClearChatButton extends StatelessWidget {
  const ClearChatButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outline_rounded),
      tooltip: 'Clear chat',
      onPressed: () {
        showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Clear Chat'),
            content: const Text(
              'Are you sure you want to clear all messages? '
              'This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Clear'),
              ),
            ],
          ),
        ).then((confirmed) {
          if (confirmed == true) onPressed();
        });
      },
    );
  }
}
