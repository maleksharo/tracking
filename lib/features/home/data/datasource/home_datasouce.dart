import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/bases/base_params/no_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/app/network/app_api.dart';
import 'package:tracking/features/home/data/models/car_location_model.dart';
import 'package:tracking/features/home/data/models/cars_data_model.dart';
import 'package:tracking/features/home/data/models/vehicle_routes_model.dart';
import 'package:tracking/features/home/data/models/vehicle_trips_model.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

abstract class HomeRemoteDataSource {
  Future<Result<RecordsCarsDataModel>> getVehiclesData();

  Future<Result<RecordsVehicleRoutesModel>> getVehicleRoutesBetweenTwoTimes({
    required TripParams tripParams,
    required int tracCarDeviceId,
  });

  Future<Result<RecordsCarLocationModel>> getVehicleLastOneHourRoute({required int tracCarDeviceId});

  Future<Result<RecordsVehicleTripsModel>> getVehicleTripsBetweenTwoTime({
    required int tracCarDeviceId,
    required TripParams tripParams,
  });
}

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final AppServiceClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<Result<RecordsCarLocationModel>> getVehicleLastOneHourRoute({required int tracCarDeviceId}) async {
    return await client.getVehicleLastOneHourRoute(
        params: const Params(params: NoParams()), tracCarDeviceId: tracCarDeviceId);
  }

  @override
  Future<Result<RecordsVehicleTripsModel>> getVehicleTripsBetweenTwoTime({
    required int tracCarDeviceId,
    required TripParams tripParams,
  }) async {
    return await client.getVehicleTripsBetweenTwoTime(
      params: Params(params: tripParams),
      tracCarDeviceId: tracCarDeviceId,
    );
  }

  @override
  Future<Result<RecordsCarsDataModel>> getVehiclesData() async {
    return await client.getVehiclesData(params: const Params(params: NoParams()));
  }

  @override
  Future<Result<RecordsVehicleRoutesModel>> getVehicleRoutesBetweenTwoTimes({
    required TripParams tripParams,
    required int tracCarDeviceId,
  }) async {
    return await client.getVehicleRoutesBetweenTwoTimes(
      params: Params(params: tripParams),
      tracCarDeviceId: tracCarDeviceId,
    );
  }
}
