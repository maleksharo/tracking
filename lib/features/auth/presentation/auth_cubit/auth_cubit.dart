import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/core/bases/base_response.dart';
import 'package:tracking/app/core/bases/base_usecase.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/auth/domain/entity/user_entity.dart';
import 'package:tracking/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/get_servers_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/get_user_info_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final SetUserInfoUseCase setUserInfoUseCase;
  final GetServerUseCase getServerUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final AppPreferences appPreferences;

  AuthCubit({
    required this.getUserInfoUseCase,
    required this.setUserInfoUseCase,
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.appPreferences,
    required this.getServerUseCase,
  }) : super(GetServersLoadingState());

  Future<void> login({required String login, required String password}) async {
    emit(LoginLoadingState());
    (await loginUseCase.execute(LoginUseCaseParams(login: login, password: password))).fold(
          (l) {
        emit(LoginFailState(l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
          (userEntity) async {
        emit(LoginSuccessState(userEntity: userEntity));
      },
    );
  }

  Future<void> forgotPassword({required String login}) async {
    emit(ForgotPasswordLoadingState());
    (await forgotPasswordUseCase.execute(ForgotPasswordUseCaseParams(login: login))).fold(
      (l) {
        emit(ForgotPasswordFailState(l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (userEntity) async {
        emit(ForgotPasswordSuccessState(baseResponse: userEntity));
      },
    );
  }

  Future<void> getServers() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) => emit(GetServersLoadingState()));

    (await getServerUseCase.execute(Void)).fold(
      (l) {
        emit(GetServersFailState(l.errorMessage ?? LocaleKeys.defaultError.tr()));
      },
      (servers) async {
        emit(GetServersSuccessState(servers: servers));
      },
    );
  }

  void setUserInfo({
    required String token,
    required String email,
    required String password,
  }) {
    setUserInfoUseCase.execute(SetUserInfoUseCaseParams(
      token: token,
      password: password,
      email: email,
    ));
  }

  Future<SetUserInfoUseCaseParams> getUserInfo(){
    return getUserInfoUseCase.execute(NoUseCaseParams());
  }
}
