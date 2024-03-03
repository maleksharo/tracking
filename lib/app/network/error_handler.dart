// import 'package:dio/dio.dart';
// import 'package:tracking/app/network/failure.dart';
// import 'package:tracking/app/resources/strings_manager.g.dart';
// import 'package:easy_localization/easy_localization.dart';
//
// class ErrorHandler implements Exception {
//   late Failure failure;
//
//   ErrorHandler.handle(dynamic error) {
//     if (error is DioException) {
//       /// dio error -> error from api or dio
//       failure = _handleError(error);
//     } else {
//       /// default error
//       failure = DataSource.defaultError.getFailure();
//     }
//   }
// }
//
// enum DataSource {
//   success,
//   noContent,
//   badRequest,
//   forbidden,
//   unauthorized,
//   notFound,
//   internalServerError,
//   connectionTimeOut,
//   cancel,
//   receiveTimeout,
//   sendTimeout,
//   cacheError,
//   noInternetConnection,
//   defaultError,
// }
//
// Failure _handleError(DioException error) {
//   switch (error.type) {
//     case DioExceptionType.connectionTimeout:
//       return DataSource.connectionTimeOut.getFailure();
//     case DioExceptionType.sendTimeout:
//       return DataSource.sendTimeout.getFailure();
//     case DioExceptionType.receiveTimeout:
//       return DataSource.receiveTimeout.getFailure();
//     case DioExceptionType.badResponse:
//       if (error.response != null && error.response?.statusCode! != null && error.response?.statusMessage! != null) {
//         return Failure(error.response!.statusCode!, error.response!.statusMessage!);
//       } else {
//         return DataSource.defaultError.getFailure();
//       }
//     case DioExceptionType.cancel:
//       return DataSource.cancel.getFailure();
//     case DioExceptionType.unknown:
//       return DataSource.defaultError.getFailure();
//     case DioExceptionType.badCertificate:
//       return DataSource.defaultError.getFailure();
//     case DioExceptionType.connectionError:
//       return DataSource.connectionTimeOut.getFailure();
//
//     default:
//       return DataSource.defaultError.getFailure();
//   }
// }
//
// extension DataSourceExtention on DataSource {
//   Failure getFailure() {
//     switch (this) {
//       case DataSource.success:
//         return Failure(ResponseCode.success, ResponseMessage.success.tr());
//       case DataSource.noContent:
//         return Failure(ResponseCode.noContent, ResponseMessage.noContent.tr());
//       case DataSource.badRequest:
//         return Failure(ResponseCode.badRequest, ResponseMessage.badRequest.tr());
//       case DataSource.forbidden:
//         return Failure(ResponseCode.forbidden, ResponseMessage.forbidden.tr());
//       case DataSource.unauthorized:
//         return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized.tr());
//       case DataSource.notFound:
//         return Failure(ResponseCode.notFound, ResponseMessage.notFound.tr());
//       case DataSource.internalServerError:
//         return Failure(ResponseCode.internalServerError, ResponseMessage.internetServerError.tr());
//       case DataSource.connectionTimeOut:
//         return Failure(ResponseCode.connectionTimeout, ResponseMessage.connectionTimeout.tr());
//       case DataSource.cancel:
//         return Failure(ResponseCode.cancel, ResponseMessage.cancel.tr());
//       case DataSource.receiveTimeout:
//         return Failure(ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout.tr());
//       case DataSource.sendTimeout:
//         return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout.tr());
//       case DataSource.cacheError:
//         return Failure(ResponseCode.cacheError, ResponseMessage.cacheError.tr());
//       case DataSource.noInternetConnection:
//         return Failure(
//           ResponseCode.noInternetConnection,
//           ResponseMessage.noInternetConnection.tr(),
//         );
//       case DataSource.defaultError:
//         return Failure(ResponseCode.defaultError, ResponseMessage.defaultError.tr());
//     }
//   }
// }
//
// class ResponseCode {
//   static const int success = 200;
//   static const int noContent = 201;
//   static const int badRequest = 400;
//   static const int forbidden = 403;
//   static const int unauthorized = 401;
//   static const int internalServerError = 500;
//   static const int notFound = 404;
//
//   /// local status code
//   static const int connectionTimeout = -1;
//   static const int cancel = -2;
//   static const int receiveTimeout = -3;
//   static const int sendTimeout = -4;
//   static const int cacheError = -5;
//   static const int noInternetConnection = -6;
//   static const int defaultError = -7;
// }
//
// class ResponseMessage {
//   static String success = LocaleKeys.success.tr();
//   static String noContent = LocaleKeys.noContent.tr();
//   static String badRequest = LocaleKeys.badRequest.tr();
//   static String forbidden = LocaleKeys.forbidden.tr();
//   static String unauthorized = LocaleKeys.unauthorized.tr();
//   static String internetServerError = LocaleKeys.internalServerError.tr();
//   static String notFound = LocaleKeys.notFound.tr();
//
//   /// local status
//   static String connectionTimeout = LocaleKeys.connectionTimeout.tr();
//   static String cancel = LocaleKeys.cancel.tr();
//   static String receiveTimeout = LocaleKeys.receiveTimeout.tr();
//   static String sendTimeout = LocaleKeys.sendTimeout.tr();
//   static String cacheError = LocaleKeys.cacheError.tr();
//   static String noInternetConnection = LocaleKeys.noInternetConnection.tr();
//   static String defaultError = LocaleKeys.defaultError.tr();
// }
//
// class ApiInternalStatus {
//   static const int success = 200;
//   static const int failure = 1;
// }
