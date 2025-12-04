import 'dart:io';
import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';

class PhotosRow extends StatelessWidget {
  final AddProductController ctrl;
  const PhotosRow({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final iconColor = theme.colorScheme.onSurface.withOpacity(0.85);
    final removeBg = theme.colorScheme.onSurface.withOpacity(0.25);

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ctrl.productPhotos.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          // ------------------ ADD IMAGE BUTTON ------------------
          if (i == ctrl.productPhotos.length) {
            return GestureDetector(
              onTap: () => ctrl.pickImages(),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  color: surfaceColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.colorScheme.onBackground.withOpacity(0.15),
                  ),
                ),
                child: Icon(Icons.add_a_photo, size: 28, color: iconColor),
              ),
            );
          }

          // ------------------ DISPLAY ADDED PHOTO ------------------
          final path = ctrl.productPhotos[i];
          ImageProvider imageProvider;
          if (path.startsWith('http')) {
            imageProvider = NetworkImage(path);
          } else if (path.startsWith('assets/')) {
            imageProvider = AssetImage(path);
          } else {
            imageProvider = FileImage(File(path));
          }

          return Stack(
            children: [
              Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: surfaceColor,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // ------------------ REMOVE ICON ------------------
              Positioned(
                right: 6,
                top: 6,
                child: GestureDetector(
                  onTap: () => ctrl.removePhoto(i),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: removeBg,
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
