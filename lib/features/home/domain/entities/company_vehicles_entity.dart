import 'package:tracking/app/core/entities/entity.dart';

class CompanyVehiclesEntity extends Entity {
  final int id;
  final String deviceName;
  final int tracCarDeviceId;

  CompanyVehiclesEntity({required this.id, required this.deviceName, required this.tracCarDeviceId});

  @override
  List<Object?> get props => [id];
}
