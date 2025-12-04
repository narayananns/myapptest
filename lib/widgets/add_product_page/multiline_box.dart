import 'package:flutter/material.dart';

class MultilineBox extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool hasError;

  const MultilineBox({
    super.key,
    required this.controller,
    required this.hint,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.colorScheme.surface.withOpacity(0.9);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.colorScheme.onSurface.withOpacity(0.5);
    final borderColor = hasError
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface.withOpacity(0.3);

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: hasError ? 1.5 : 1.0),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: hasError ? theme.colorScheme.error : hintColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
