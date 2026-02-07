import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/extensions/context_extensions.dart';

enum ReportReason {
  inappropriate('Inappropriate behavior'),
  harassment('Harassment'),
  spam('Spam'),
  other('Other');

  const ReportReason(this.label);
  final String label;
}

class ReportDialog extends StatefulWidget {
  const ReportDialog({
    required this.targetName,
    super.key,
  });

  final String targetName;

  /// Shows the dialog and returns the selected [ReportReason], or `null`.
  static Future<ReportReason?> show(
    BuildContext context, {
    required String targetName,
  }) {
    return showDialog<ReportReason>(
      context: context,
      builder: (_) => ReportDialog(targetName: targetName),
    );
  }

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  ReportReason? _selected;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Report ${widget.targetName}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Why are you reporting this user?',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.spacing12),
          RadioGroup<ReportReason>(
            groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ReportReason.values
                  .map(
                    (reason) => RadioListTile<ReportReason>(
                      title: Text(reason.label),
                      value: reason,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _selected != null
              ? () => Navigator.of(context).pop(_selected)
              : null,
          style: TextButton.styleFrom(
            foregroundColor: context.colorScheme.error,
          ),
          child: const Text('Report'),
        ),
      ],
    );
  }
}
