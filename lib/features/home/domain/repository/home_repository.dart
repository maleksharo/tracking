import 'package:dartz/dartz.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_routes_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';


abstract class HomeRepository {
  Future<Either<ErrorEntity, RecordsCarsDataEntity>> getVehiclesData();

  Future<Either<ErrorEntity, RecordsVehicleRoutesEntity>> getVehicleRoutesBetweenTwoTimes({
    required TripParams tripParams,
    required int tracCarDeviceId,
  });

  Future<Either<ErrorEntity, RecordsCarLocationEntity>> getVehicleLastOneHourRoute({required int tracCarDeviceId});

  Future<Either<ErrorEntity,RecordsVehicleTripsEntity>> getVehicleTripsBetweenTwoTime({
    required int tracCarDeviceId,
    required TripParams tripParams,
  });
}