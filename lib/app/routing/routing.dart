import 'package:flutter/material.dart';
import 'package:news/presentation/auth/login_view.dart';
import 'package:news/presentation/splash/splash_view.dart';
import 'package:news/presentation/home/home_view.dart';
import 'package:news/presentation/article_detail/article_detail_view.dart';
import 'package:news/data/models/news_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/app/di/service_locator.dart';
import 'package:news/presentation/article_detail/cubit/article_detail_cubit.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case AppRoutes.articleDetail:
      final article = settings.arguments as Article?;
      if (article == null) {
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No article provided'))),
        );
      }
      return MaterialPageRoute(
        builder: (_) => BlocProvider<ArticleDetailCubit>(
          create: (_) => getIt<ArticleDetailCubit>(),
          child: ArticleDetailView(article: article),
        ),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
