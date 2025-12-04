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
        final h = constraints.maxHeight;

        // Responsive sizes based on the smaller dimension to ensure fit
        final sizeRef = w < h ? w : h;
        final iconSize = (sizeRef * 0.25).clamp(24.0, 36.0);
        final titleFont = (sizeRef * 0.12).clamp(12.0, 16.0);

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
            padding: EdgeInsets.all(w * 0.05), // Reduced padding
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.black.withOpacity(0.12),
                width: 1,
              ),
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
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          )
                        : const SizedBox(height: 8, width: 8),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ],
                ),

                // ---------------- CENTER CONTENT ----------------
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: iconSize, color: theme.primaryColor),

                      SizedBox(height: h * 0.05),

                      Flexible(
                        child: Text(
                          title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: titleFont,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
