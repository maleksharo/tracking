import 'package:json_annotation/json_annotation.dart';
import 'package:tracking/app/extensions.dart';
import 'package:tracking/features/home/domain/entities/company_vehicles_entity.dart';

part 'company_vehicles_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyVehiclesModel {
  final int? id;
  final String? deviceName;
  final int? tracCarDeviceId;

  CompanyVehiclesModel({required this.id, required this.deviceName, required this.tracCarDeviceId,});

  CompanyVehiclesEntity toEntity() =>
      CompanyVehiclesEntity(
          id: id.orZero(),
          deviceName: deviceName.orEmpty(),
          tracCarDeviceId: tracCarDeviceId.orZero()
      );

  factory CompanyVehiclesModel.fromEntity(CompanyVehiclesEntity companyVehiclesEntity) {
    return CompanyVehiclesModel(
        id: companyVehiclesEntity.id,
        deviceName: companyVehiclesEntity.deviceName,
        tracCarDeviceId: companyVehiclesEntity.tracCarDeviceId
    );
  }

  factory CompanyVehiclesModel.fromJson(Map<String, dynamic> json) => _$CompanyVehiclesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyVehiclesModelToJson(this);
}









