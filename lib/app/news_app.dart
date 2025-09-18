import 'package:flutter/material.dart';
import 'package:news/app/routing/routes.dart';
import 'package:news/app/routing/routing.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
