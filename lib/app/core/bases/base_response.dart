import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'errors')
  final List<String?>? errors;


  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  BaseResponse({required this.message, required this.success, required this.statusCode, required this.errors});

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
