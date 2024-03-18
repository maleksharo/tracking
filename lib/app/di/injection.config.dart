// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;
import 'package:tracking/app/app_prefs.dart' as _i3;
import 'package:tracking/app/config/configuration.dart' as _i7;
import 'package:tracking/app/core/interceptors/auth_interceptor.dart' as _i6;
import 'package:tracking/app/di/injection_module.dart' as _i30;
import 'package:tracking/app/network/app_api.dart' as _i12;
import 'package:tracking/app/routes/auth_guard.dart' as _i5;
import 'package:tracking/app/routes/router.dart' as _i4;
import 'package:tracking/features/auth/data/datasource/local_datasource.dart'
    as _i9;
import 'package:tracking/features/auth/data/datasource/remote_datasource.dart'
    as _i16;
import 'package:tracking/features/auth/data/repository/repository_impl.dart'
    as _i18;
import 'package:tracking/features/auth/domain/repository/repository.dart'
    as _i17;
import 'package:tracking/features/auth/domain/usecase/forgot_password_usecase.dart'
    as _i21;
import 'package:tracking/features/auth/domain/usecase/get_servers_usecase.dart'
    as _i25;
import 'package:tracking/features/auth/domain/usecase/get_user_info_usecase.dart'
    as _i27;
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart'
    as _i19;
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart'
    as _i20;
import 'package:tracking/features/auth/presentation/auth_cubit/auth_cubit.dart'
    as _i29;
import 'package:tracking/features/home/data/datasource/home_datasouce.dart'
    as _i13;
import 'package:tracking/features/home/data/repository/home_repository_impl.dart'
    as _i15;
import 'package:tracking/features/home/domain/repository/home_repository.dart'
    as _i14;
import 'package:tracking/features/home/domain/usecases/get_car_location_usecase.dart'
    as _i22;
import 'package:tracking/features/home/domain/usecases/get_car_trip_route_usecase.dart'
    as _i23;
import 'package:tracking/features/home/domain/usecases/get_cars_data_usecase.dart'
    as _i24;
import 'package:tracking/features/home/domain/usecases/get_trip_info_usecase.dart'
    as _i26;
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart'
    as _i28;
import 'package:tracking/features/settings/cubit/settings_cubit.dart' as _i10;

const String _prod = 'prod';
const String _test = 'test';
const String _dev = 'dev';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i3.AppPreferences>(() => _i3.AppPreferences());
    gh.lazySingleton<_i4.AppRouter>(() => injectableModule.router);
    gh.factory<_i5.AuthGuard>(() => _i5.AuthGuard(gh<_i3.AppPreferences>()));
    gh.lazySingleton<_i6.AuthInterceptor>(
        () => _i6.AuthInterceptor(gh<_i3.AppPreferences>()));
    gh.lazySingleton<_i7.Configuration>(
      () => _i7.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i7.Configuration>(
      () => _i7.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i7.Configuration>(
      () => _i7.StagingConfiguration(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i8.Dio>(() => injectableModule.dioInstance);
    gh.factory<_i9.LoginLocalDataSource>(() =>
        _i9.LoginLocalDataSourceImpl(appPreferences: gh<_i3.AppPreferences>()));
    gh.factory<_i10.SettingsCubit>(
        () => _i10.SettingsCubit(gh<_i3.AppPreferences>()));
    await gh.lazySingletonAsync<_i11.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i12.AppServiceClient>(() => _i12.AppServiceClient(
          gh<_i8.Dio>(),
          gh<_i7.Configuration>(),
        ));
    gh.factory<_i13.HomeRemoteDataSource>(() =>
        _i13.HomeRemoteDataSourceImpl(client: gh<_i12.AppServiceClient>()));
    gh.factory<_i14.HomeRepository>(
        () => _i15.HomeRepositoryImpl(gh<_i13.HomeRemoteDataSource>()));
    gh.factory<_i16.LoginRemoteDataSource>(() =>
        _i16.LoginRemoteDataSourceImpl(client: gh<_i12.AppServiceClient>()));
    gh.factory<_i17.LoginRepository>(() => _i18.LoginRepositoryImpl(
          gh<_i16.LoginRemoteDataSource>(),
          gh<_i9.LoginLocalDataSource>(),
        ));
    gh.factory<_i19.LoginUseCase>(
        () => _i19.LoginUseCase(gh<_i17.LoginRepository>()));
    gh.factory<_i20.SetUserInfoUseCase>(
        () => _i20.SetUserInfoUseCase(gh<_i17.LoginRepository>()));
    gh.factory<_i21.ForgotPasswordUseCase>(
        () => _i21.ForgotPasswordUseCase(gh<_i17.LoginRepository>()));
    gh.factory<_i22.GetCarLocationUseCase>(
        () => _i22.GetCarLocationUseCase(gh<_i14.HomeRepository>()));
    gh.factory<_i23.GetCarTripRouteUseCase>(
        () => _i23.GetCarTripRouteUseCase(gh<_i14.HomeRepository>()));
    gh.factory<_i24.GetCarsDataUseCase>(
        () => _i24.GetCarsDataUseCase(gh<_i14.HomeRepository>()));
    gh.factory<_i25.GetServerUseCase>(
        () => _i25.GetServerUseCase(gh<_i17.LoginRepository>()));
    gh.factory<_i26.GetTripInfoUseCase>(
        () => _i26.GetTripInfoUseCase(gh<_i14.HomeRepository>()));
    gh.factory<_i27.GetUserInfoUseCase>(
        () => _i27.GetUserInfoUseCase(gh<_i17.LoginRepository>()));
    gh.lazySingleton<_i28.HomeCubit>(() => _i28.HomeCubit(
          gh<_i22.GetCarLocationUseCase>(),
          gh<_i23.GetCarTripRouteUseCase>(),
          gh<_i24.GetCarsDataUseCase>(),
          gh<_i26.GetTripInfoUseCase>(),
          gh<_i3.AppPreferences>(),
        ));
    gh.factory<_i29.AuthCubit>(() => _i29.AuthCubit(
          getUserInfoUseCase: gh<_i27.GetUserInfoUseCase>(),
          setUserInfoUseCase: gh<_i20.SetUserInfoUseCase>(),
          loginUseCase: gh<_i19.LoginUseCase>(),
          forgotPasswordUseCase: gh<_i21.ForgotPasswordUseCase>(),
          appPreferences: gh<_i3.AppPreferences>(),
          getServerUseCase: gh<_i25.GetServerUseCase>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i30.InjectableModule {}
