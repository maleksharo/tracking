import 'package:injectable/injectable.dart';

abstract class Configuration {
  String get getBaseUrl;
}

@LazySingleton(as: Configuration, env: [Environment.dev])
class DevConfiguration extends Configuration {
  @override
  String get getBaseUrl => 'https://togetzr.com/api';
}

@LazySingleton(as: Configuration, env: [Environment.test])
class StagingConfiguration extends Configuration {
  @override
  String get getBaseUrl => 'https://togetzr.com/api';
}

@LazySingleton(as: Configuration, env: [Environment.prod])
class ProductionConfiguration extends Configuration {
  @override
  String get getBaseUrl => 'https://togetzr.com/api';
}
