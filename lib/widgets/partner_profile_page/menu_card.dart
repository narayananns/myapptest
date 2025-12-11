import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool showDot;
  final Widget? navigateTo;

  const MenuCard({
    super.key,
    required this.imagePath,
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
        final iconSize = (sizeRef * 0.35).clamp(30.0, 48.0);
        final titleFont = (sizeRef * 0.13).clamp(12.0, 16.0);

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
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(31, 31, 31, 1),
              borderRadius: BorderRadius.circular(10),
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
            child: Stack(
              children: [
                // ---------------- TOP ROW ----------------
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Row(
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
                ),

                // ---------------- CENTER CONTENT ----------------
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        imagePath,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: h * 0.03),

                      Flexible(
                        child: Text(
                          title,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1,
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
