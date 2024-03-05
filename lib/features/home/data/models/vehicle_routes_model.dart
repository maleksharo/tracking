import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/home/domain/entities/vehicle_routes_entity.dart';

part 'vehicle_routes_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecordsVehicleRoutesModel {
  final List<VehicleRoutesModel> records;

  RecordsVehicleRoutesModel({required this.records});

  RecordsVehicleRoutesEntity toEntity() => RecordsVehicleRoutesEntity(
        vehicleRoutes: records.map((e) => e.toEntity()).toList(),
      );

  factory RecordsVehicleRoutesModel.fromEntity(RecordsVehicleRoutesEntity vehicleRoutesEntity) {
    return RecordsVehicleRoutesModel(
      records: vehicleRoutesEntity.vehicleRoutes.map((e) => VehicleRoutesModel.fromEntity(e)).toList(),
    );
  }

  factory RecordsVehicleRoutesModel.fromJson(Map<String, dynamic> json) => _$RecordsVehicleRoutesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordsVehicleRoutesModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class VehicleRoutesModel {
  final String? fixTime;
  final double? latitude;
  final double? longitude;
  final double? speed;
  final dynamic address;

  VehicleRoutesModel({
    required this.fixTime,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.address,
  });

  VehicleRoutesEntity toEntity() => VehicleRoutesEntity(
        fixTime: fixTime.orEmpty(),
        latitude: latitude.orZero(),
        longitude: longitude.orZero(),
        speed: speed.orZero(),
        address: address,
      );

  factory VehicleRoutesModel.fromEntity(VehicleRoutesEntity vehicleRoutesEntity) {
    return VehicleRoutesModel(
      fixTime: vehicleRoutesEntity.fixTime,
      latitude: vehicleRoutesEntity.latitude,
      longitude: vehicleRoutesEntity.longitude,
      speed: vehicleRoutesEntity.speed,
      address: vehicleRoutesEntity.address,
    );
  }

  factory VehicleRoutesModel.fromJson(Map<String, dynamic> json) => _$VehicleRoutesModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleRoutesModelToJson(this);
}
