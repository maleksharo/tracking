// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_usecase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUseCaseParams _$LoginUseCaseParamsFromJson(Map<String, dynamic> json) =>
    LoginUseCaseParams(
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginUseCaseParamsToJson(LoginUseCaseParams instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };
