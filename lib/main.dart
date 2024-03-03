import 'package:tracking/app/app.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import 'app/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureInjection(Environment.prod);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        ensureScreenSize: true,
        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: EasyLocalization(
            supportedLocales: const [arabicLocale, englishLocale],
            fallbackLocale: englishLocale,
            path: assetPathLocalization,
            child: const MyApp(),
          ),
        ),
      ),
    );
  });
}
