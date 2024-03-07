// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result<T> _$ResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Result<T>(
      result: json['result'] == null
          ? null
          : ApiResponse<T>.fromJson(json['result'] as Map<String, dynamic>,
              (value) => fromJsonT(value)),
    );



ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      message: json['messasge'] as String,
      status: json['status'] as bool? ?? false,
      response: _$nullableGenericFromJson(json['response'], fromJsonT),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'response': _$nullableGenericToJson(instance.response, toJsonT),
      'messasge': instance.message,
      'status': instance.status,
      'success': instance.success,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
