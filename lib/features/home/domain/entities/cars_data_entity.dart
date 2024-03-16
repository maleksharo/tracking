import 'package:tracking/app/core/entities/entity.dart';

class RecordsCarsDataEntity extends Entity {
  final List<CarsDataEntity> carsList;

  RecordsCarsDataEntity({required this.carsList});

  @override
  List<Object?> get props => [carsList];
}

class CarsDataEntity extends Entity {
  final int deviceId;
  final String deviceName;
  final dynamic licensePlate;
  final LocationEntity locationEntity;
  final DriverEntity driverEntity;
  final String status;
  final String lastUpdate;
  final dynamic workingDaysFrom;
  final dynamic workingDaysTo;
  final String workFrom;
  final String workTo;
  final String breakBetFrom;
  final String breakBetTo;
  final int breakDuration;
  final String dateLocalization;
  final String lastAddress;

  CarsDataEntity({
    required this.deviceId,
    required this.deviceName,
    required this.licensePlate,
    required this.locationEntity,
    required this.driverEntity,
    required this.status,
    required this.lastUpdate,
    required this.workingDaysFrom,
    required this.workingDaysTo,
    required this.workFrom,
    required this.workTo,
    required this.breakBetFrom,
    required this.breakBetTo,
    required this.breakDuration,
    required this.dateLocalization,
    required this.lastAddress,
  });

  @override
  List<Object?> get props => [deviceId];
}

class LocationEntity extends Entity {
  final double latitude;
  final double longitude;

  LocationEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class DriverEntity extends Entity {
  final int id;
  final String name;

  DriverEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id];
}
