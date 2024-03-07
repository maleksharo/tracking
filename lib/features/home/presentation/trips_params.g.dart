// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripParams _$TripParamsFromJson(Map<String, dynamic> json) => TripParams(
      from: json['from'] as String,
      to: json['to'] as String,
      tracCarDeviceId: json['trac_car_device_id'] as int,
    );

Map<String, dynamic> _$TripParamsToJson(TripParams instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'trac_car_device_id': instance.tracCarDeviceId,
    };
