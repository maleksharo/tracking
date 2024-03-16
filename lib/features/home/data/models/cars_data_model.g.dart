// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordsCarsDataModel _$RecordsCarsDataModelFromJson(
        Map<String, dynamic> json) =>
    RecordsCarsDataModel(
      records: (json['records'] as List<dynamic>)
          .map((e) => CarsDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecordsCarsDataModelToJson(
        RecordsCarsDataModel instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

CarsDataModel _$CarsDataModelFromJson(Map<String, dynamic> json) =>
    CarsDataModel(
      dateLocalization: json['date_localization'] as String?,
      lastAddress: json['last_address'] as String?,
      deviceId: json['device_id'] as int?,
      deviceName: json['device_name'] as String?,
      licensePlate: json['license_plate'],
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      driverId: json['driver_id'] == null
          ? null
          : DriverModel.fromJson(json['driver_id'] as Map<String, dynamic>),
      status: json['status'] as String?,
      lastUpdate: json['lastUpdate'] as String?,
      workingDaysFrom: json['working_days_from'],
      workingDaysTo: json['working_days_to'],
      workFrom: json['work_from'] as String?,
      workTo: json['work_to'] as String?,
      breakBetFrom: json['break_bet_from'] as String?,
      breakBetTo: json['break_bet_to'] as String?,
      breakDuration: json['break_duration'] as int?,
    );

Map<String, dynamic> _$CarsDataModelToJson(CarsDataModel instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'license_plate': instance.licensePlate,
      'location': instance.location,
      'driver_id': instance.driverId,
      'status': instance.status,
      'lastUpdate': instance.lastUpdate,
      'working_days_from': instance.workingDaysFrom,
      'working_days_to': instance.workingDaysTo,
      'work_from': instance.workFrom,
      'work_to': instance.workTo,
      'break_bet_from': instance.breakBetFrom,
      'break_bet_to': instance.breakBetTo,
      'break_duration': instance.breakDuration,
      'date_localization': instance.dateLocalization,
      'last_address': instance.lastAddress,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) => DriverModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
