// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Params<T> _$ParamsFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Params<T>(
      params: fromJsonT(json['params']),
    );

Map<String, dynamic> _$ParamsToJson<T>(
  Params<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'params': toJsonT(instance.params),
    };
