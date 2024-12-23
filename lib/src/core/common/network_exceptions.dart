import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_response_message.dart';

part 'network_exceptions.freezed.dart';

@Freezed(
  map: FreezedMapOptions(map: true),
)
class NetworkExceptions with _$NetworkExceptions {
  //Error With Status Code
  //400
  const factory NetworkExceptions.badRequest({String? reason}) = BadRequest;
  //401
  const factory NetworkExceptions.unauthorisedRequest({String? reason}) =
      UnauthorisedRequest;
  //403
  const factory NetworkExceptions.forbiddenRequest({String? reason}) =
      ForbiddenRequest;
  //404
  const factory NetworkExceptions.notFound({String? reason}) = NotFound;
  //405
  const factory NetworkExceptions.methodNotAllowed({String? reason}) =
      MethodNotAllowed;
//406
  const factory NetworkExceptions.notAcceptable({String? reason}) =
      NotAcceptable;
  //408
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
//409
  const factory NetworkExceptions.conflict() = Conflict;
  //422
  const factory NetworkExceptions.unprocessableEntity(
    ErrorResponseMessage? reasons,
  ) = UnprocessableEntity;
//500
  const factory NetworkExceptions.internalServerError() = InternalServerError;
//503
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.unexpectedError({String? error}) = UnexpectedError;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.certificateFailed() = CertificateFailed;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  // ignore: prefer_constructors_over_static_methods
  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        late NetworkExceptions networkExceptions;
        if (error is DioException) {
          networkExceptions = whenDioError(error);
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (err) {
        log('E: $error');
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        log('#=====================');
        log('E: $error');
        log('=====================#');
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static NetworkExceptions whenDioError(DioException error) {
    late NetworkExceptions networkExceptions;
    switch (error.type) {
      case DioExceptionType.unknown:
        networkExceptions = const NetworkExceptions.unexpectedError();
        break;
      case DioExceptionType.connectionTimeout:
        networkExceptions = const NetworkExceptions.requestTimeout();
        break;
      case DioExceptionType.sendTimeout:
        networkExceptions = const NetworkExceptions.sendTimeout();
        break;
      case DioExceptionType.receiveTimeout:
        networkExceptions = const NetworkExceptions.receiveTimeout();
        break;
      case DioExceptionType.cancel:
        networkExceptions = const NetworkExceptions.requestCancelled();
        break;
      case DioExceptionType.connectionError:
        networkExceptions = const NetworkExceptions.noInternetConnection();
        break;
      case DioExceptionType.badCertificate:
        networkExceptions = const NetworkExceptions.certificateFailed();
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            networkExceptions = NetworkExceptions.badRequest(
              reason: error.response?.data['error'],
            );
            break;
          case 401:
            networkExceptions = NetworkExceptions.unauthorisedRequest(
              reason: error.response?.data['error'],
            );
            break;
          case 403:
            networkExceptions = NetworkExceptions.forbiddenRequest(
              reason: error.response?.data['error'],
            );
            break;
          case 404:
            networkExceptions = NetworkExceptions.notFound(
              reason: error.response?.data['error'],
            );
            break;
          case 405:
            networkExceptions = NetworkExceptions.methodNotAllowed(
                reason: error.response?.data['error']);
            break;
          case 406:
            networkExceptions = NetworkExceptions.notAcceptable(
                reason: error.response?.data['error']);
            break;
          case 408:
            networkExceptions = const NetworkExceptions.requestTimeout();
            break;
          case 409:
            networkExceptions = const NetworkExceptions.conflict();
            break;
          case 422:
            networkExceptions = NetworkExceptions.unprocessableEntity(
              ErrorResponseMessage.fromJson(error.response?.data),
            );
            break;
          case 500:
            networkExceptions = const NetworkExceptions.internalServerError();
            break;
          case 501:
            networkExceptions = const NetworkExceptions.notImplemented();
            break;
          case 503:
            networkExceptions = const NetworkExceptions.serviceUnavailable();
            break;

          default:
            final int? responseCode = error.response?.statusCode;
            networkExceptions = NetworkExceptions.defaultError(
              "Received invalid status code: $responseCode",
            );
        }
        break;
    }

    return networkExceptions;
  }
}
