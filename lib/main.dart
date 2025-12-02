import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'models/profile_page/theme_provider.dart';
import 'providers/dashboard_home_provider.dart';
import 'providers/analytics_provider.dart';
import 'providers/profile_provider.dart';

// Screens
import 'screens/partner_home_page.dart';
import 'screens/parnter_analytics_page.dart';
import 'screens/partner_profile_page.dart';

// Theme
import 'config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
        ChangeNotifierProvider(create: (_) => PartnerProvider()),
      ],
      child: const AppWithTheme(),
    );
  }
}

class AppWithTheme extends StatelessWidget {
  const AppWithTheme({super.key});

  Route _slideRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: child,
        );
      },
    );
  }

  Route _fadeRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, animation, __) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Partner Dashboard',

      /// 🌗 APPLY NEW THEMES HERE
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

      initialRoute: '/home',

      /// PAGE ANIMATIONS + ROUTES
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/analytics':
            return _fadeRoute(settings, const PartnerAnalyticsPage());

          case '/profile':
            return _slideRoute(settings, const PartnerProfilePage());

          case '/home':
          default:
            return _slideRoute(settings, const PartnerHomePage());
        }
      },
    );
  }
}
