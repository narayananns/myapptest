import 'package:flutter/material.dart';

class FileUploadBox extends StatelessWidget {
  final String title;
  final String? fileName;
  final VoidCallback onTap;

  const FileUploadBox({
    super.key,
    required this.title,
    this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 30),
              const SizedBox(height: 5),
              Text(fileName ?? title, style: const TextStyle(color: Colors.grey)),
              const Text("5 MB max file size", style: TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
