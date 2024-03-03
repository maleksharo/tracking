import 'dart:io';

import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class UserNotLoggedInAuthException implements Exception {}

class CouldNotUpdateDataException implements Exception {}

class AppException implements Exception {
  late final String? _message;
  late final int? _code;

  String? get message => _message;

  int? get code => _code;

  late final dynamic data;

  AppException(this.data, [this._message, this._code]);

  AppException.fromDioResponse(Map<String, dynamic> json){
    _message = json['metaData']['message'] ?? LocaleKeys.defaultError.tr();
    _code = json['metaData']['status'] ?? 200;
    data = json['data'];
  }

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException({String? message, data})
      : super(data, message = message ?? LocaleKeys.unKnownError.tr());
}

class NoInternetException extends AppException {
  NoInternetException({String? message, data})
      : super(
          data,
          message = LocaleKeys.noInternetConnection.tr(),
        );
}

class NoItemsException extends AppException {
  NoItemsException({String? message, data})
      : super(
          data,
          message = LocaleKeys.noItems.tr(),
        );
}

class BadRequestException extends AppException {
  BadRequestException({String? message, data})
      : super(
          data,
          message = LocaleKeys.badRequest.tr(),
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message, data})
      : super(
          data,
          message = LocaleKeys.unauthorized.tr(),
        );
}

class NotFoundException extends AppException {
  NotFoundException({String? message, data})
      : super(
          data,
          message = LocaleKeys.notFound.tr(),
        );
}

class InvalidInputException extends AppException {
  InvalidInputException({String? message, data})
      : super(
          data,
          message = message ?? LocaleKeys.invalidInput.tr(),
        );
}

class ServerErrorException extends AppException {
  ServerErrorException({String? message, data})
      : super(
          data,
          message = LocaleKeys.internalServerError.tr(),
        );
}

class CacheException extends AppException {
  CacheException({String? message, data})
      : super(
          data,
          message = LocaleKeys.cacheError.tr(),
        );
}

class SessionTimedOutException extends AppException {
  SessionTimedOutException({String? message, data})
      : super(
          data,
          message = LocaleKeys.sessionTimedOut.tr(),
        );
}

extension ExceptionExten on DioException {
  AppException convertToAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NoInternetException();
      case DioExceptionType.badResponse:
        if (response?.statusCode == 403) {
          return UnauthorisedException();
        } else {
          return AppException.fromDioResponse(response?.data);
        }
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        if(error is SocketException){
          return NoInternetException();
        }
        return FetchDataException();
    }
  }
}
