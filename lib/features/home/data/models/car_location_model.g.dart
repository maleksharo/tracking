// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordsCarLocationModel _$RecordsCarLocationModelFromJson(
        Map<String, dynamic> json) =>
    RecordsCarLocationModel(
      records: (json['records'] as List<dynamic>)
          .map((e) => CarLocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsCarLocationModelToJson(
        RecordsCarLocationModel instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

CarLocationModel _$CarLocationModelFromJson(Map<String, dynamic> json) =>
    CarLocationModel(
      id: json['id'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      deviceId: json['device_id'] as int?,
    );

Map<String, dynamic> _$CarLocationModelToJson(CarLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed': instance.speed,
      'device_id': instance.deviceId,
    };
