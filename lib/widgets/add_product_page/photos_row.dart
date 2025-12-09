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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: ctrl.productPhotos.length + 1,
      itemBuilder: (context, i) {
        // ------------------ ADD IMAGE BUTTON ------------------
        if (i == ctrl.productPhotos.length) {
          return GestureDetector(
            onTap: () => ctrl.pickImages(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(176, 176, 176, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.15),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 28, color: Colors.black),
                  SizedBox(height: 4),
                  Text(
                    "Tap to\nAdd Images",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: surfaceColor,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
    );
  }
}
