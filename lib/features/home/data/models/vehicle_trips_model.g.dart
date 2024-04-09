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
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      averageSpeed: (json['averageSpeed'] as num?)?.toDouble(),
      startLat: (json['startLat'] as num?)?.toDouble(),
      startLon: (json['startLon'] as num?)?.toDouble(),
      endLat: (json['endLat'] as num?)?.toDouble(),
      endLon: (json['endLon'] as num?)?.toDouble(),
      duration: json['duration'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      startAddress: json['startAddress'],
      endAddress: json['endAddress'],
    );

Map<String, dynamic> _$VehicleTripsModelToJson(VehicleTripsModel instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'averageSpeed': instance.averageSpeed,
      'startLat': instance.startLat,
      'startLon': instance.startLon,
      'endLat': instance.endLat,
      'endLon': instance.endLon,
      'duration': instance.duration,
      'distance': instance.distance,
      'startAddress': instance.startAddress,
      'endAddress': instance.endAddress,
    };
