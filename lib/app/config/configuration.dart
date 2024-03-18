import 'package:injectable/injectable.dart';
import 'package:tracking/app/app_prefs.dart';

import '../di/injection.dart';

abstract class Configuration {
  String get getBaseUrl;
}

@LazySingleton(as: Configuration, env: [Environment.dev])
class DevConfiguration extends Configuration {
  @override
  String get getBaseUrl => 'https://test.itieit.com/api';
}

@LazySingleton(as: Configuration, env: [Environment.test])
class StagingConfiguration extends Configuration {
  @override
  String get getBaseUrl => 'https://test.itieit.com/api';
}

@LazySingleton(as: Configuration, env: [Environment.prod])
class ProductionConfiguration extends Configuration {
  final AppPreferences appPreferences = getIt<AppPreferences>();
  @override
  String get getBaseUrl => "https://${appPreferences.getString(prefsKey: prefsBaseUrl)}itieit.com/api/" ;
}
