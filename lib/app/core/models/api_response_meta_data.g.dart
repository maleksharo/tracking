// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseMetaData _$ApiResponseMetaDataFromJson(Map<String, dynamic> json) =>
    ApiResponseMetaData(
      status: json['status'] as int? ?? -1,
      key: json['key'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ApiResponseMetaDataToJson(
        ApiResponseMetaData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'key': instance.key,
    };
