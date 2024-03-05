// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_trips_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordsVehicleTripsModel _$RecordsVehicleTripsModelFromJson(
        Map<String, dynamic> json) =>
    RecordsVehicleTripsModel(
      records: (json['records'] as List<dynamic>)
          .map((e) => VehicleTripsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsVehicleTripsModelToJson(
        RecordsVehicleTripsModel instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

VehicleTripsModel _$VehicleTripsModelFromJson(Map<String, dynamic> json) =>
    VehicleTripsModel(
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      averageSpeed: (json['average_speed'] as num?)?.toDouble(),
      startLat: (json['start_lat'] as num?)?.toDouble(),
      startLon: (json['start_lon'] as num?)?.toDouble(),
      endLat: (json['end_lat'] as num?)?.toDouble(),
      endLon: (json['end_lon'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      startAddress: json['start_address'] as String?,
      endAddress: json['end_address'],
    );

Map<String, dynamic> _$VehicleTripsModelToJson(VehicleTripsModel instance) =>
    <String, dynamic>{
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'average_speed': instance.averageSpeed,
      'start_lat': instance.startLat,
      'start_lon': instance.startLon,
      'end_lat': instance.endLat,
      'end_lon': instance.endLon,
      'duration': instance.duration,
      'distance': instance.distance,
      'start_address': instance.startAddress,
      'end_address': instance.endAddress,
    };
