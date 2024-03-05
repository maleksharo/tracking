import 'package:tracking/app/core/entities/entity.dart';

class RecordsVehicleRoutesEntity extends Entity {
  final List<VehicleRoutesEntity> vehicleRoutes;

  RecordsVehicleRoutesEntity({required this.vehicleRoutes});

  @override
  List<Object?> get props => [vehicleRoutes];
}

class VehicleRoutesEntity extends Entity {
  final String fixTime;
  final double latitude;
  final double longitude;
  final double speed;
  final dynamic address;

  VehicleRoutesEntity(
      {required this.fixTime,
      required this.latitude,
      required this.longitude,
      required this.speed,
      required this.address});

  @override
  List<Object?> get props => [];
}
