import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/core/interceptors/auth_interceptor.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/routes/router.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appPreferences = getIt<AppPreferences>();

  @override
  void initState() {
    super.initState();
    getIt<Dio>().interceptors.add(getIt<AuthInterceptor>());
  }

  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) => {context.setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getApplicationTheme(),
      routerConfig: getIt<AppRouter>().config(),
    );
  }
}
