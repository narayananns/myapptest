import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        textCapitalization: obscureText
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.0,
            color: Color.fromRGBO(166, 166, 166, 1),
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18, // Adjusted for 58px height
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(180, 180, 180, 1),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromRGBO(180, 180, 180, 1),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
