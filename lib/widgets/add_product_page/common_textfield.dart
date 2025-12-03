import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;

  const CommonTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: readOnly ? onTap : null,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade900,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
