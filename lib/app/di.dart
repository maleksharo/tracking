// import 'package:tracking/app/app_prefs.dart';
// import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
// import 'package:tracking/app/network/app_api.dart';
// import 'package:tracking/app/network/dio_factory.dart';
// import 'package:tracking/app/network/network_info.dart';
// import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
// import 'package:tracking/features/auth/presentation/auth_cubit/auth_cubit.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// final instance = GetIt.instance;
//
// /// Get it is like a map type that have all project instances
// /// and I can access what I need through instance dynamiciable
//
// /// Factory each time we call it we will have a new instance
// /// singleton have only one instance
//
// /// when we want to add abstract class to di => return it's implementer
// Future<void> initAppModule() async {
//   /// App module, it's a module where we put all generic dependencies
//   /// Lazy the instance will sleep until you call it.
//
//   final sharedPrefs = await SharedPreferences.getInstance();
//   instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
//
//   /// App prefs instance
//   instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
//
//   /// Network info
//   instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));
//
//   /// Dio factory
//   instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
//   Dio dio = await instance<DioFactory>().getDio();
//
//   /// App service client
//   instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
//
//   /// remote data source
//   // instance.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(instance()));
//
//   /// repository
//   // instance.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(instance(), instance()));
//
//   /// refresh cubit
//   instance.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
//   // instance.registerLazySingleton<NotificationsCubit>(() => NotificationsCubit(instance(), instance(), instance()));
//   // initNotificationsModule();
// }
//
// void initLoginModule() {
//   if (!GetIt.I.isRegistered<LoginUseCase>()) {
//     instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
//     instance.registerLazySingleton<LoginCubit>(() => LoginCubit(
//           loginUseCase: instance(),
//           appPreferences: instance(),
//         ));
//   }
// }
