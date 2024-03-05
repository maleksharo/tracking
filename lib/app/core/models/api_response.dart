import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class Result<T> extends Equatable {
  @JsonKey(defaultValue: null)
  final ApiResponse<T>? result;

  const Result({required this.result});

  const Result.data({required this.result});

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ResultFromJson(json, fromJsonT);

  @override
  List<Object?> get props => [result];
}

@JsonSerializable(genericArgumentFactories: true, includeIfNull: true, fieldRename: FieldRename.snake)
class ApiResponse<T> extends Equatable {
  @JsonKey(defaultValue: null)
  final T? response;

  final String message;
  final bool status;
  final bool success;

  const ApiResponse({
    required this.message,
    this.status = false,
    required this.response,
    this.success = false,
  });

  const ApiResponse.data({
    required this.message,
    required this.status,
    required this.success,
    required this.response,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [response];
}

