import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:tracking/app/config/configuration.dart';
import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/bases/base_params/no_params.dart';
import 'package:tracking/app/core/bases/base_response.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/features/auth/data/models/user_model.dart';
import 'package:tracking/features/auth/domain/usecase/forgot_password_usecase.dart';
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

  @POST("/reset/password/")
  Future<Result<BaseResponse>> forgotPassword(
    @Body() Params<ForgotPasswordUseCaseParams> params,
  );

  @POST("/vehicles")
  Future<Result<RecordsCarsDataModel>> getVehiclesData({
    @Body() required Params<NoParams> params,
  });


  @POST("/{tracCarDeviceId}/vehicle-routes/")
  Future<Result<RecordsVehicleRoutesModel>> getVehicleRoutesBetweenTwoTimes({
    @Body() required Params<TripParams> params,
    @Path() required int tracCarDeviceId,
  });

  @POST("/{tracCarDeviceId}/last-route")
  Future<Result<RecordsCarLocationModel>> getVehicleLastOneHourRoute({
    @Body() required Params<NoParams> params,
    @Path() required int tracCarDeviceId,
  });

  @POST("/{tracCarDeviceId}/vehicle-trips/")
  Future<Result<RecordsVehicleTripsModel>> getVehicleTripsBetweenTwoTime({
    @Body() required Params<TripParams> params,
    @Path() required int tracCarDeviceId,
  });


  @POST("/get/databases/")
  Future<Result<List<String>>> getServers({
    @Body() required Params<NoParams> params,
  });
}
