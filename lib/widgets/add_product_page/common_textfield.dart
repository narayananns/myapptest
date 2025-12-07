import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final bool hasError;

  const CommonTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintColor = theme.colorScheme.onSurface.withOpacity(0.5);
    final borderColor = hasError
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface.withOpacity(0.15);

    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: readOnly ? onTap : null,
      keyboardType: keyboardType,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: hasError ? theme.colorScheme.error : hintColor,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(63, 63, 63, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: hasError
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
