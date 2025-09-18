import 'package:flutter/material.dart';
import 'package:news/presentation/auth/login_view.dart';
import 'package:news/presentation/splash/splash_view.dart';
import 'package:news/presentation/home/home_view.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeView());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
