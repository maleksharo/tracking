import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';

part 'vehicle_trips_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecordsVehicleTripsModel {
  final List<VehicleTripsModel> records;

  RecordsVehicleTripsModel({required this.records});

  RecordsVehicleTripsEntity toEntity() => RecordsVehicleTripsEntity(
        vehicleTrips: records.map((e) => e.toEntity()).toList(),
      );

  factory RecordsVehicleTripsModel.fromEntity(RecordsVehicleTripsEntity vehicleRoutesEntity) {
    return RecordsVehicleTripsModel(
      records: vehicleRoutesEntity.vehicleTrips.map((e) => VehicleTripsModel.fromEntity(e)).toList(),
    );
  }

  factory RecordsVehicleTripsModel.fromJson(Map<String, dynamic> json) => _$RecordsVehicleTripsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsVehicleTripsModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none)
class VehicleTripsModel {
  final String? startTime;
  final String? endTime;
  final double? averageSpeed;
  final double? startLat;
  final double? startLon;
  final double? endLat;
  final double? endLon;
  final double? duration;
  final double? distance;
  final dynamic startAddress;
  final dynamic endAddress;

  VehicleTripsModel(
      {required this.startTime,
      required this.endTime,
      required this.averageSpeed,
      required this.startLat,
      required this.startLon,
      required this.endLat,
      required this.endLon,
      required this.duration,
      required this.distance,
      required this.startAddress,
      required this.endAddress});

  VehicleTripsEntity toEntity() => VehicleTripsEntity(
        startTime: startTime.orEmpty(),
        endTime: endTime.orEmpty(),
        averageSpeed: averageSpeed.orZero(),
        startLat: startLat.orZero(),
        startLon: startLon.orZero(),
        endLat: endLat.orZero(),
        endLon: endLon.orZero(),
        duration: duration.orZero(),
        distance: distance.orZero(),
        startAddress: startAddress ?? "",
        endAddress: endAddress ?? "",
      );

  factory VehicleTripsModel.fromEntity(VehicleTripsEntity vehicleTripsEntity) {
    return VehicleTripsModel(
      startTime: vehicleTripsEntity.startTime,
      endTime: vehicleTripsEntity.endTime,
      averageSpeed: vehicleTripsEntity.averageSpeed,
      startLat: vehicleTripsEntity.startLat,
      startLon: vehicleTripsEntity.startLon,
      endLat: vehicleTripsEntity.endLat,
      endLon: vehicleTripsEntity.endLon,
      duration: vehicleTripsEntity.duration,
      distance: vehicleTripsEntity.distance,
      startAddress: vehicleTripsEntity.startAddress,
      endAddress: vehicleTripsEntity.endAddress,
    );
  }

  factory VehicleTripsModel.fromJson(Map<String, dynamic> json) => _$VehicleTripsModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleTripsModelToJson(this);
}
