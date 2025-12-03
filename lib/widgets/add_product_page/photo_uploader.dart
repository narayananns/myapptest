import 'package:flutter/material.dart';

class PhotoUploader extends StatelessWidget {
  final List<String> photos;
  final Function() onAdd;
  final Function(int) onDelete;

  const PhotoUploader({
    super.key,
    required this.photos,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        ...List.generate(
          photos.length,
          (i) => Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(photos[i], fit: BoxFit.cover),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => onDelete(i),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, size: 14, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: onAdd,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        )
      ],
    );
  }
}
