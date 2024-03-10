import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/entities/error_entity.dart';
import 'package:tracking/app/network/exceptions.dart';
import 'package:tracking/features/home/data/datasource/home_datasouce.dart';
import 'package:tracking/features/home/domain/entities/car_location_entity.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/domain/entities/company_vehicles_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_routes_entity.dart';
import 'package:tracking/features/home/domain/entities/vehicle_trips_entity.dart';
import 'package:tracking/features/home/domain/repository/home_repository.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<ErrorEntity, RecordsCarLocationEntity>> getVehicleLastOneHourRoute({required int tracCarDeviceId}) async {
    try {
      final response = await homeRemoteDataSource.getVehicleLastOneHourRoute(tracCarDeviceId: tracCarDeviceId);
      if (response.result?.success == true) {
        return Right(response.result!.response!.toEntity());
      } else {
        return Left(ErrorEntity(
          errorMessage: response.result?.message,
        ));
      }
    } on DioException catch (e) {
      return Left(ErrorEntity.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorEntity, RecordsVehicleTripsEntity>> getVehicleTripsBetweenTwoTime({
    required int tracCarDeviceId,
    required TripParams tripParams,
  }) async {
    try {
      final response =
          await homeRemoteDataSource.getVehicleTripsBetweenTwoTime(tracCarDeviceId: tracCarDeviceId, tripParams: tripParams);
      if (response.result?.success == true) {
        return Right(response.result!.response!.toEntity());
      } else {
        return Left(ErrorEntity(
          errorMessage: response.result?.message,
        ));
      }
    } on DioException catch (e) {
      return Left(ErrorEntity.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorEntity, RecordsCarsDataEntity>> getVehiclesData() async {
    try {
      final response = await homeRemoteDataSource.getVehiclesData();
      if (response.result?.success == true) {
        return Right(response.result!.response!.toEntity());
      } else {
        return Left(ErrorEntity(
          errorMessage: response.result?.message,
        ));
      }
    } on DioException catch (e) {
      return Left(ErrorEntity.fromException(e.convertToAppException()));
    }
  }



  @override
  Future<Either<ErrorEntity, RecordsVehicleRoutesEntity>> getVehicleRoutesBetweenTwoTimes({
    required TripParams tripParams,
    required int tracCarDeviceId,
  }) async {
    try {
      final response = await homeRemoteDataSource.getVehicleRoutesBetweenTwoTimes(
        tracCarDeviceId: tracCarDeviceId,
        tripParams: tripParams,
      );
      if (response.result?.success == true) {
        return Right(response.result!.response!.toEntity());
      } else {
        return Left(ErrorEntity(
          errorMessage: response.result?.message,
        ));
      }
    } on DioException catch (e) {
      return Left(ErrorEntity.fromException(e.convertToAppException()));
    }
  }
}
