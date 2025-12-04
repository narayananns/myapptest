import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final bool hasError;

  const DropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface.withOpacity(0.85);
    final textColor = theme.colorScheme.onSurface;
    final hintColor = theme.colorScheme.onSurface.withOpacity(0.5);
    final borderColor = hasError
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface.withOpacity(0.15);

    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,

      decoration: InputDecoration(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: TextStyle(
          color: hasError ? theme.colorScheme.error : hintColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),

      dropdownColor: theme.colorScheme.surface,
      style: TextStyle(color: textColor, fontSize: 15),

      hint: Text(
        hint,
        style: TextStyle(color: hasError ? theme.colorScheme.error : hintColor),
      ),

      items: items.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e, style: TextStyle(color: textColor)),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }
}
