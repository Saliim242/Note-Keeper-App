import 'package:flutter/material.dart';

import '../utils/exports.dart';

class MessageState extends StatelessWidget {
  const MessageState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(NSizes.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: NAppColor.kPrimaryColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: NAppColor.kPrimaryColor, size: 34),
          ),
          const SizedBox(height: NSizes.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: NAppColor.kTextStyleColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: NSizes.xs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: NAppColor.kTextStyleColorGray,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
