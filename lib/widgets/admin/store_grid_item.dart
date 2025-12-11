import 'package:flutter/material.dart';
import '../../models/admin/admin_dashboard_model.dart';

/// Store Grid Item Widget
/// Displays a store logo in a circular container with store name
class StoreGridItem extends StatelessWidget {
  final StoreModel store;
  final VoidCallback? onTap;

  const StoreGridItem({
    super.key,
    required this.store,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Store Logo Container
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFF9800), // Orange border
                width: 2,
              ),
              color: _getStoreBackgroundColor(store.name),
            ),
            child: store.logoUrl.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      store.logoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildStoreIcon(store.name),
                    ),
                  )
                : _buildStoreIcon(store.name),
          ),
          const SizedBox(height: 8),
          // Store Name
          Text(
            store.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildStoreIcon(String storeName) {
    // Custom icons/logos based on store name
    if (storeName.toLowerCase().contains('supervek')) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'SUPERVEK',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (storeName.toLowerCase().contains('burger')) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'BURGER',
            style: TextStyle(
              color: Color(0xFFFF9800),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (storeName.toLowerCase().contains('thristo')) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4DD0E1),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.checkroom,
            color: Colors.black,
            size: 30,
          ),
        ),
      );
    } else if (storeName.toLowerCase().contains('shades')) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'PROJECT\nSHADES',
            style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (storeName.toLowerCase().contains('home')) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade700,
              Colors.amber.shade400,
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.home,
            color: Colors.black,
            size: 30,
          ),
        ),
      );
    } else {
      // Default icon
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            storeName.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  Color _getStoreBackgroundColor(String storeName) {
    if (storeName.toLowerCase().contains('supervek') ||
        storeName.toLowerCase().contains('burger')) {
      return Colors.black;
    } else if (storeName.toLowerCase().contains('thristo')) {
      return const Color(0xFF4DD0E1);
    } else if (storeName.toLowerCase().contains('shades')) {
      return Colors.white;
    } else if (storeName.toLowerCase().contains('home')) {
      return Colors.amber.shade700;
    } else {
      return Colors.white;
    }
  }
}

