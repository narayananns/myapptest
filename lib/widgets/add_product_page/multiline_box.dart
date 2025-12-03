import 'package:flutter/material.dart';

class MultilineBox extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const MultilineBox({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        expands: true,
        maxLines: null,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
