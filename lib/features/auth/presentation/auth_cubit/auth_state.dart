part of 'auth_cubit.dart';

@immutable
abstract class LoginState {}

/// login
class LoginInitialState implements LoginState {}

class LoginLoadingState implements LoginState {}

class LoginFailState implements LoginState {
  final String message;

  LoginFailState(this.message);
}

class LoginSuccessState implements LoginState {
  final UserEntity userEntity;

  LoginSuccessState({required this.userEntity});
}
