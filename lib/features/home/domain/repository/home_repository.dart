import 'package:dartz/dartz.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/domain/entities/company_vehicles_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_routes_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';


abstract class HomeRepository {
  Future<Either<ErrorEntity,RecordsCarsDataEntity>> getCarsData();

  Future<Either<ErrorEntity,List<CompanyVehiclesEntity>>> getCompanyVehicles();

  Future<Either<ErrorEntity,RecordsVehicleRoutesEntity>> getTripInfo({
    required TripParams tripParams,
    required int tracCarDeviceId,
  });

  Future<Either<ErrorEntity,RecordsCarLocationEntity>> getCarLocation({required int tracCarDeviceId});

  Future<Either<ErrorEntity,RecordsVehicleTripsEntity>> getCarTripRoute({
    required int tracCarDeviceId,
    required TripParams tripParams,
  });
}