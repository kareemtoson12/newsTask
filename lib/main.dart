import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:news/app/news_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DevicePreview(enabled: true, builder: (context) => const NewsApp()));
}
