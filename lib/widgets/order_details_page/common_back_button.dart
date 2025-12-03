import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back, size: 26),
    );
  }
}
