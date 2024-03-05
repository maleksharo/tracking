// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_vehicles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyVehiclesModel _$CompanyVehiclesModelFromJson(
        Map<String, dynamic> json) =>
    CompanyVehiclesModel(
      id: json['id'] as int?,
      deviceName: json['device_name'] as String?,
      tracCarDeviceId: json['trac_car_device_id'] as int?,
    );

Map<String, dynamic> _$CompanyVehiclesModelToJson(
        CompanyVehiclesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.deviceName,
      'trac_car_device_id': instance.tracCarDeviceId,
    };
