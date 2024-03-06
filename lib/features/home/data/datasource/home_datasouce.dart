import 'package:injectable/injectable.dart';
import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/bases/base_params/no_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/app/network/app_api.dart';
import 'package:tracking/features/home/data/models/car_location_model.dart';
import 'package:tracking/features/home/data/models/cars_data_model.dart';
import 'package:tracking/features/home/data/models/company_vehicles_model.dart';
import 'package:tracking/features/home/data/models/vehicle_routes_model.dart';
import 'package:tracking/features/home/data/models/vehicle_trips_model.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

abstract class HomeRemoteDataSource {
  Future<Result<CarsDataModel>> getCarsData();

  Future<Result<List<CompanyVehiclesModel>>> getCompanyVehicles();

  Future<Result<RecordsVehicleRoutesModel>> getTripInfo({
    required TripParams tripParams,
    required int tracCarDeviceId,
  });

  Future<Result<RecordsCarLocationModel>> getCarLocation({required int tracCarDeviceId});

  Future<Result<RecordsVehicleTripsModel>> getCarTripRoute({
    required int tracCarDeviceId,
    required TripParams tripParams,
  });
}

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final AppServiceClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<Result<RecordsCarLocationModel>> getCarLocation({required int tracCarDeviceId}) async {
    return await client.getCarLocation(params: const Params(params: NoParams()), tracCarDeviceId: tracCarDeviceId);
  }

  @override
  Future<Result<RecordsVehicleTripsModel>> getCarTripRoute({
    required int tracCarDeviceId,
    required TripParams tripParams,
  }) async {
    return await client.getCarTripRoute(
      params: Params(params: tripParams),
      tracCarDeviceId: tracCarDeviceId,
    );
  }

  @override
  Future<Result<CarsDataModel>> getCarsData() async {
    return await client.getCarsData(params: const Params(params: NoParams()));
  }

  @override
  Future<Result<List<CompanyVehiclesModel>>> getCompanyVehicles() async {
    return await client.getCompanyVehicles(params: const Params(params: NoParams()));
  }

  @override
  Future<Result<RecordsVehicleRoutesModel>> getTripInfo({
    required TripParams tripParams,
    required int tracCarDeviceId,
  }) async {
    return await client.getTripInfo(
      params: Params(params: tripParams),
      tracCarDeviceId: tracCarDeviceId,
    );
  }
}
