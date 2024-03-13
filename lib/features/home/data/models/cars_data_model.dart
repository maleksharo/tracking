import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';

part 'cars_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecordsCarsDataModel {
  final List<CarsDataModel> records;

  RecordsCarsDataModel({required this.records});

  RecordsCarsDataEntity toEntity() => RecordsCarsDataEntity(
        carsList: records.map((e) => e.toEntity()).toList(),
      );

  factory RecordsCarsDataModel.fromEntity(RecordsCarsDataEntity recordsCarsDataEntity) {
    return RecordsCarsDataModel(
      records: recordsCarsDataEntity.carsList.map((e) => CarsDataModel.fromEntity(e)).toList(),
    );
  }

  factory RecordsCarsDataModel.fromJson(Map<String, dynamic> json) => _$RecordsCarsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsCarsDataModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CarsDataModel {
  final int? deviceId;
  final String? deviceName;
  final dynamic licensePlate;
  final LocationModel? location;
  final DriverModel? driverId;
  final String? status;
  @JsonKey(name: 'lastUpdate')
  final String? lastUpdate;
  final dynamic workingDaysFrom;
  final dynamic workingDaysTo;
  final String? workFrom;
  final String? workTo;
  final String? breakBetFrom;
  final String? breakBetTo;
  final int? breakDuration;

  CarsDataModel({
    required this.deviceId,
    required this.deviceName,
    required this.licensePlate,
    required this.location,
    required this.driverId,
    required this.status,
    required this.lastUpdate,
    required this.workingDaysFrom,
    required this.workingDaysTo,
    required this.workFrom,
    required this.workTo,
    required this.breakBetFrom,
    required this.breakBetTo,
    required this.breakDuration,
  });

  CarsDataEntity toEntity() {
    return CarsDataEntity(
    deviceId: deviceId.orZero(),
        deviceName: deviceName.orEmpty(),
        licensePlate: licensePlate,
        locationEntity: location!.toEntity(),
        driverEntity: driverId!.toEntity(),
        status: status.orEmpty(),
        lastUpdate: lastUpdate.orEmpty(),
        workingDaysFrom: workingDaysFrom,
        workingDaysTo: workingDaysTo,
        workFrom: workFrom.orEmpty(),
        workTo: workTo.orEmpty(),
        breakBetFrom: breakBetFrom.orEmpty(),
        breakBetTo: breakBetTo.orEmpty(),
        breakDuration: breakDuration.orZero(),
      );
  }

  factory CarsDataModel.fromEntity(CarsDataEntity carsDataEntity) {
    return CarsDataModel(
      deviceId: carsDataEntity.deviceId.orZero(),
      deviceName: carsDataEntity.deviceName.orEmpty(),
      licensePlate: carsDataEntity.licensePlate,
      location: LocationModel.fromEntity(carsDataEntity.locationEntity),
      driverId: DriverModel.fromEntity(carsDataEntity.driverEntity),
      status: carsDataEntity.status.orEmpty(),
      lastUpdate: carsDataEntity.lastUpdate.orEmpty(),
      workingDaysFrom: carsDataEntity.workingDaysFrom,
      workingDaysTo: carsDataEntity.workingDaysTo,
      workFrom: carsDataEntity.workFrom.orEmpty(),
      workTo: carsDataEntity.workTo.orEmpty(),
      breakBetFrom: carsDataEntity.breakBetFrom.orEmpty(),
      breakBetTo: carsDataEntity.breakBetTo.orEmpty(),
      breakDuration: carsDataEntity.breakDuration.orZero(),
    );
  }

  factory CarsDataModel.fromJson(Map<String, dynamic> json) => _$CarsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarsDataModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LocationModel {
  final double? latitude;
  final double? longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  LocationEntity toEntity() => LocationEntity(
        latitude: latitude.orZero(),
        longitude: longitude.orZero(),
      );

  factory LocationModel.fromEntity(LocationEntity locationEntity) {
    return LocationModel(
      latitude: locationEntity.latitude,
      longitude: locationEntity.longitude,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverModel {
  final int? id;
  final String? name;

  DriverModel({
    required this.id,
    required this.name,
  });

  DriverEntity toEntity() => DriverEntity(
        id: id.orZero(),
        name: name.orEmpty(),
      );

  factory DriverModel.fromEntity(DriverEntity driverEntity) {
    return DriverModel(
      id: driverEntity.id,
      name: driverEntity.name,
    );
  }

  factory DriverModel.fromJson(Map<String, dynamic> json) => _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
