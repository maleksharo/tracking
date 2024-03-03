// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      statusCode: json['status_code'] as int?,
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'success': instance.success,
      'status_code': instance.statusCode,
      'errors': instance.errors,
    };
