import 'package:tracking/app/core/entities/entity.dart';

class RecordsVehicleTripsEntity extends Entity {
  final List<VehicleTripsEntity> vehicleTrips;

  RecordsVehicleTripsEntity({required this.vehicleTrips});

  @override
  List<Object?> get props => [vehicleTrips];
}

class VehicleTripsEntity extends Entity {
  final String startTime;
  final String endTime;
  final double averageSpeed;
  final double startLat;
  final double startLon;
  final double endLat;
  final double endLon;
  final double duration;
  final double distance;
  final String startAddress;
  final String endAddress;

  VehicleTripsEntity(
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

  @override
  List<Object?> get props => [startTime, endTime];
}
