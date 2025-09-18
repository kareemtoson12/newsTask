import 'package:flutter/material.dart';
import 'package:news/app/routing/routes.dart';
import 'package:news/app/routing/routing.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/app/di/service_locator.dart';
import 'package:news/presentation/home/cubit/home_cubit.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) =>
              getIt<HomeCubit>()
                ..loadHeadlines(country: 'us', category: 'general'),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
