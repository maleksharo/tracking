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
import 'package:shared_preferences/shared_preferences.dart' as _i10;
import 'package:tracking/app/app_prefs.dart' as _i3;
import 'package:tracking/app/config/configuration.dart' as _i7;
import 'package:tracking/app/core/interceptors/auth_interceptor.dart' as _i6;
import 'package:tracking/app/di/injection_module.dart' as _i19;
import 'package:tracking/app/network/app_api.dart' as _i11;
import 'package:tracking/app/routes/auth_guard.dart' as _i5;
import 'package:tracking/app/routes/router.dart' as _i4;
import 'package:tracking/features/auth/data/datasource/local_datasource.dart'
    as _i9;
import 'package:tracking/features/auth/data/datasource/remote_datasource.dart'
    as _i12;
import 'package:tracking/features/auth/data/repository/repository_impl.dart'
    as _i14;
import 'package:tracking/features/auth/domain/repository/repository.dart'
    as _i13;
import 'package:tracking/features/auth/domain/usecase/get_user_info_usecase.dart'
    as _i17;
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart'
    as _i15;
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart'
    as _i16;
import 'package:tracking/features/auth/presentation/auth_cubit/auth_cubit.dart'
    as _i18;

const String _dev = 'dev';
const String _test = 'test';
const String _prod = 'prod';

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
      () => _i7.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i7.Configuration>(
      () => _i7.StagingConfiguration(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i7.Configuration>(
      () => _i7.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i8.Dio>(() => injectableModule.dioInstance);
    gh.factory<_i9.LoginLocalDataSource>(() =>
        _i9.LoginLocalDataSourceImpl(appPreferences: gh<_i3.AppPreferences>()));
    await gh.lazySingletonAsync<_i10.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i11.AppServiceClient>(() => _i11.AppServiceClient(
          gh<_i8.Dio>(),
          gh<_i7.Configuration>(),
        ));
    gh.factory<_i12.LoginRemoteDataSource>(() =>
        _i12.LoginRemoteDataSourceImpl(client: gh<_i11.AppServiceClient>()));
    gh.factory<_i13.LoginRepository>(() => _i14.LoginRepositoryImpl(
          gh<_i12.LoginRemoteDataSource>(),
          gh<_i9.LoginLocalDataSource>(),
        ));
    gh.factory<_i15.LoginUseCase>(
        () => _i15.LoginUseCase(gh<_i13.LoginRepository>()));
    gh.factory<_i16.SetUserInfoUseCase>(
        () => _i16.SetUserInfoUseCase(gh<_i13.LoginRepository>()));
    gh.factory<_i17.GetUserInfoUseCase>(
        () => _i17.GetUserInfoUseCase(gh<_i13.LoginRepository>()));
    gh.factory<_i18.AuthCubit>(() => _i18.AuthCubit(
          getUserInfoUseCase: gh<_i17.GetUserInfoUseCase>(),
          setUserInfoUseCase: gh<_i16.SetUserInfoUseCase>(),
          loginUseCase: gh<_i15.LoginUseCase>(),
          appPreferences: gh<_i3.AppPreferences>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i19.InjectableModule {}
