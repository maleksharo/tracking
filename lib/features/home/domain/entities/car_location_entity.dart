import 'package:tracking/app/core/entities/entity.dart';

class RecordsCarLocationEntity extends Entity {
  final List<CarLocationEntity> carLocations;

  RecordsCarLocationEntity({required this.carLocations});

  @override
  List<Object?> get props => [carLocations];
}

class CarLocationEntity extends Entity {
  final int id;
  final double latitude;
  final double longitude;
  final double speed;
  final int deviceId;

  CarLocationEntity(
      {required this.id, required this.latitude, required this.longitude, required this.speed, required this.deviceId});

  @override
  List<Object?> get props => [id, deviceId];
}
