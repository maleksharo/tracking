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
  Future<Either<ErrorEntity, RecordsCarLocationEntity>> getCarLocation({required int tracCarDeviceId}) async {
    try {
      final response = await homeRemoteDataSource.getCarLocation(tracCarDeviceId: tracCarDeviceId);
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
  Future<Either<ErrorEntity, RecordsVehicleTripsEntity>> getCarTripRoute({
    required int tracCarDeviceId,
    required TripParams tripParams,
  }) async {
    try {
      final response =
          await homeRemoteDataSource.getCarTripRoute(tracCarDeviceId: tracCarDeviceId, tripParams: tripParams);
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
  Future<Either<ErrorEntity, CarsDataEntity>> getCarsData() async {
    try {
      final response = await homeRemoteDataSource.getCarsData();
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
  Future<Either<ErrorEntity, List<CompanyVehiclesEntity>>> getCompanyVehicles() async {
    try {
      final response = await homeRemoteDataSource.getCompanyVehicles();
      if (response.result?.success == true) {
        return Right(response.result!.response!.map((e) => e.toEntity()).toList());
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
  Future<Either<ErrorEntity, RecordsVehicleRoutesEntity>> getTripInfo({
    required TripParams tripParams,
    required int tracCarDeviceId,
  }) async {
    try {
      final response = await homeRemoteDataSource.getTripInfo(
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
