import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String image;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Stack(
          children: [
            // ---------------- PROFILE IMAGE ----------------
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: theme.brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.40)
                        : Colors.grey.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _loadImage(image),
              ),
            ),

            // ---------------- EDIT BUTTON ----------------
            Positioned(
              right: 6,
              top: 6,
              child: InkWell(
                onTap: () {
                  // TODO: Add edit functionality
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // ---------------- "Profile" LABEL ----------------
        Text(
          "Profile",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onBackground.withOpacity(0.7),
          ),
        ),

        const SizedBox(height: 6),

        // ---------------- USER NAME ----------------
        Text(
          name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Safely loads asset OR shows placeholder if missing
  Widget _loadImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Icon(Icons.person, size: 50, color: Colors.grey),
      ),
    );
  }
}
