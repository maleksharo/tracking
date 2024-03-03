import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:tracking/app/config/configuration.dart';
import 'package:tracking/app/core/bases/base_params/base_params.dart';
import 'package:tracking/app/core/models/api_response.dart';
import 'package:tracking/features/auth/data/models/user_model.dart';
import 'package:tracking/features/auth/domain/usecase/login_usecase.dart';

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
}
