import 'package:flutter/material.dart';
import '../../../providers/add_product_controller.dart';

class PhotosRow extends StatelessWidget {
  final AddProductController ctrl;
  const PhotosRow({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ctrl.productPhotos.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          if (i == ctrl.productPhotos.length) {
            return GestureDetector(
              onTap: () => ctrl.addPhoto("https://via.placeholder.com/200"),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add_a_photo, size: 28),
              ),
            );
          }

          return Stack(
            children: [
              Container(
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(ctrl.productPhotos[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: GestureDetector(
                  onTap: () => ctrl.removePhoto(i),
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, size: 14, color: Colors.white),
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
