import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';

part 'car_location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecordsCarLocationModel {
  final List<CarLocationModel> records;

  RecordsCarLocationModel({required this.records});

  RecordsCarLocationEntity toEntity() => RecordsCarLocationEntity(
        carLocations: records.map((e) => e.toEntity()).toList(),
      );

  factory RecordsCarLocationModel.fromEntity(RecordsCarLocationEntity vehicleRoutesEntity) {
    return RecordsCarLocationModel(
      records: vehicleRoutesEntity.carLocations.map((e) => CarLocationModel.fromEntity(e)).toList(),
    );
  }

  factory RecordsCarLocationModel.fromJson(Map<String, dynamic> json) => _$RecordsCarLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsCarLocationModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CarLocationModel {
  final int? id;
  final double? latitude;
  final double? longitude;
  final double? speed;
  final int? deviceId;

  CarLocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.deviceId,
  });

  CarLocationEntity toEntity() => CarLocationEntity(
        id: id.orZero(),
        latitude: latitude.orZero(),
        longitude: longitude.orZero(),
        speed: speed.orZero(),
        deviceId: deviceId.orZero(),
      );

  factory CarLocationModel.fromEntity(CarLocationEntity vehicleRoutesEntity) {
    return CarLocationModel(
      id: vehicleRoutesEntity.id,
      latitude: vehicleRoutesEntity.latitude,
      longitude: vehicleRoutesEntity.longitude,
      speed: vehicleRoutesEntity.speed,
      deviceId: vehicleRoutesEntity.deviceId,
    );
  }

  factory CarLocationModel.fromJson(Map<String, dynamic> json) => _$CarLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarLocationModelToJson(this);
}
