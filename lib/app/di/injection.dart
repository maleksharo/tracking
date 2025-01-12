import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {

  // if (getIt.isRegistered(instance: RefreshCubit)) {
  //   print('getIt.reset()');

  // } else {
  //   print('getIt.register()');
  //   // final sharedPrefs = await SharedPreferences.getInstance();
  //   // getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //   // getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  //   // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  //   getIt.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  //   await getIt.init(environment: env);
  // }

  if (!GetIt.I.isRegistered(instance: SharedPreferences)) {
      await getIt.reset();
    // final sharedPrefs = await SharedPreferences.getInstance();
    // getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    getIt.registerLazySingleton<Connectivity>(() => Connectivity());
    // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
    getIt.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  }

  await getIt.init(environment: env);
}
