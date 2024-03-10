import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:tracking/app/config/configuration.dart';
import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/bases/base_params/no_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/features/auth/data/models/user_model.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';
import 'package:tracking/features/home/data/models/car_location_model.dart';
import 'package:tracking/features/home/data/models/cars_data_model.dart';
import 'package:tracking/features/home/data/models/company_vehicles_model.dart';
import 'package:tracking/features/home/data/models/vehicle_routes_model.dart';
import 'package:tracking/features/home/data/models/vehicle_trips_model.dart';
import 'package:tracking/features/home/presentation/trips_params.dart';

part 'app_api.g.dart';

@lazySingleton
@RestApi()
abstract class AppServiceClient {
  @factoryMethod
  factory AppServiceClient(Dio dio, Configuration configuration) {
    return _AppServiceClient(dio, baseUrl: configuration.getBaseUrl);
  }

  @POST("/login/")
  Future<Result<UserModel>> login(
    @Body() Params<LoginUseCaseParams> params,
  );

  @POST("/vehicles")
  Future<Result<RecordsCarsDataModel>> getCarsData({
    @Body() required Params<NoParams> params,
  });

  @POST("/company/vehicle")
  Future<Result<List<CompanyVehiclesModel>>> getCompanyVehicles({
    @Body() required Params<NoParams> params,
  });

  @POST("/{tracCarDeviceId}/vehicle-routes/")
  Future<Result<RecordsVehicleRoutesModel>> getTripInfo({
    @Body() required Params<TripParams> params,
    @Path() required int tracCarDeviceId,
  });

  @POST("/{tracCarDeviceId}/last-route")
  Future<Result<RecordsCarLocationModel>> getCarLocation({
    @Body() required Params<NoParams> params,
    @Path() required int tracCarDeviceId,
  });

  @POST("/{tracCarDeviceId}/vehicle-routes/")
  Future<Result<RecordsVehicleTripsModel>> getCarTripRoute({
    @Body() required Params<TripParams> params,
    @Path() required int tracCarDeviceId,
  });
}
