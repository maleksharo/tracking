import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/routes/router.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AppPreferences appPreferences;

  AuthInterceptor(this.appPreferences);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = appPreferences.getString(prefsKey: prefsToken);
    if (token.isNotEmpty) {
      Map<String, String> headers;
      headers = {
        'user-token': appPreferences.getString(prefsKey: prefsToken),
      };
      // print("I'm HERE ${appPreferences.getString(prefsKey: prefsToken)}");
      options.headers.addAll(headers);
    }
    if (!handler.isCompleted) {
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    final statusCode = err.response?.statusCode ?? 400;
    if(statusCode == 401){
      appPreferences.logout();
      getIt<AppRouter>().replace(const LoginRoute());
    }
  }
}
