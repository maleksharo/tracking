part of 'auth_cubit.dart';

@immutable
abstract class LoginState {}

/// login

class LoginLoadingState implements LoginState {}

class LoginFailState implements LoginState {
  final String message;

  LoginFailState(this.message);
}

class LoginSuccessState implements LoginState {
  final UserEntity userEntity;

  LoginSuccessState({required this.userEntity});
}

/// forgot password
class ForgotPasswordLoadingState implements LoginState {}

class ForgotPasswordFailState implements LoginState {
  final String message;

  ForgotPasswordFailState(this.message);
}

class ForgotPasswordSuccessState implements LoginState {
  final BaseResponse baseResponse;

  ForgotPasswordSuccessState({required this.baseResponse});
}

/// servers
class GetServersLoadingState implements LoginState {}

class GetServersFailState implements LoginState {
  final String message;

  GetServersFailState(this.message);
}

class GetServersSuccessState implements LoginState {
  final List<String> servers;

  GetServersSuccessState({required this.servers});
}
