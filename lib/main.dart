import 'package:flutter/material.dart';
import 'package:mp3player/service_locator.dart';

import 'core/configs/theme/app_theme.dart';
import 'presentation/splash/pages/splash.dart';

Future<void> main() async {
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage());
  }
}
