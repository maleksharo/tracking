// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_routes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordsVehicleRoutesModel _$RecordsVehicleRoutesModelFromJson(
        Map<String, dynamic> json) =>
    RecordsVehicleRoutesModel(
      records: (json['records'] as List<dynamic>)
          .map((e) => VehicleRoutesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsVehicleRoutesModelToJson(
        RecordsVehicleRoutesModel instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

VehicleRoutesModel _$VehicleRoutesModelFromJson(Map<String, dynamic> json) =>
    VehicleRoutesModel(
      fixTime: json['fix_time'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      speed: (json['speed'] as num?)?.toDouble(),
      address: json['address'],
    );

Map<String, dynamic> _$VehicleRoutesModelToJson(VehicleRoutesModel instance) =>
    <String, dynamic>{
      'fix_time': instance.fixTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed': instance.speed,
      'address': instance.address,
    };
