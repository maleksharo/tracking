import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/core/interceptors/auth_interceptor.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/routes/router.dart';

import 'resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "ITieIt Tracking Application",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getApplicationTheme(),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
