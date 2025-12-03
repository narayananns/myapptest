import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showDot;
  final Widget? navigateTo;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    this.showDot = false,
    this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;

        // Fully responsive sizes
        final iconSize = (w * 0.18).clamp(28.0, 40.0);
        final titleFont = (w * 0.10).clamp(14.0, 20.0);

        return GestureDetector(
          onTap: () {
            if (navigateTo != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => navigateTo!),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.08,
              vertical: w * 0.09,
            ),
            decoration: BoxDecoration(
              color: theme.cardColor, // adapts to theme
              borderRadius: BorderRadius.circular(16),

              // Dynamic border (light: grey, dark: subtle)
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.black.withOpacity(0.12),
                width: 1,
              ),

              // Dynamic shadow
              boxShadow: [
                BoxShadow(
                  color: theme.brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.35)
                      : Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // ---------------- TOP ROW ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showDot
                        ? Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox(height: 10, width: 10),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),

                SizedBox(height: w * 0.05),

                // ---------------- CENTER CONTENT ----------------
                Column(
                  children: [
                    Icon(
                      icon,
                      size: iconSize,
                      color: theme.primaryColor, // theme-based
                    ),

                    SizedBox(height: w * 0.04),

                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colorScheme.onSurface, // dynamic text color
                        fontSize: titleFont,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
