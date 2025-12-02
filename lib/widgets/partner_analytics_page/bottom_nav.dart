import 'package:flutter/material.dart';

class PartnerBottomNav extends StatelessWidget {
  final int currentIndex;

  const PartnerBottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomTheme = theme.bottomNavigationBarTheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,

      // THEME-AWARE COLORS
      backgroundColor: bottomTheme.backgroundColor ?? theme.cardColor,
      selectedItemColor: bottomTheme.selectedItemColor ?? theme.primaryColor,
      unselectedItemColor: bottomTheme.unselectedItemColor ?? theme.colorScheme.onSurface.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,

      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/analytics');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: null),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart, color: null),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: null),
          label: 'Profile',
        ),
      ],
    );
  }
}
