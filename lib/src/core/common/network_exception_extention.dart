
part of 'extend_state.dart';



extension NetworkExceptionsExtension on NetworkExceptions {
  String message() {
    final l = lookupMessages;
    return when(
      defaultError: (String error) => error,
      conflict: () => l.conflict(),
      sendTimeout: () => l.sendTimeout(),
      requestTimeout: () => l.requestTimeout(),
      certificateFailed: () => l.certificateFailed(),
      receiveTimeout: () => l.receiveTimeout(),
      forbiddenRequest: (String? reason) => reason ?? l.forbiddenRequest(),
      notImplemented: () => l.notImplemented(),
      notAcceptable: (String? reason) =>  reason ?? l.formatException(),
      unableToProcess: () => l.unableToProcess(),
      unexpectedError: (String? reason) => reason ?? l.unexpectedError(),
      formatException: () => l.formatException(),
      requestCancelled: () => l.requestCancelled(),
      methodNotAllowed: (String? reason) => reason ?? l.methodNotAllowed(),
      serviceUnavailable: () => l.serviceUnavailable(),
      internalServerError: () => l.internalServerError(),
      noInternetConnection: () => l.noInternetConnection(),

      notFound: (String? reason) {
        return reason ?? l.notFound();
      },
      badRequest: (_) => l.badRequest(),
      unauthorisedRequest: (String? reason) {
        return reason ?? l.unauthorisedRequest();
      },
      unprocessableEntity: (ErrorResponseMessage? errorResponseMessage) {
        return errorResponseMessage?.message ?? l.somethingWhenWrong();
      },
    );
  }

  String messageDescription() {
    final l = lookupMessages;
    return maybeWhen(
      orElse: () => l.somethingWhenWrongDesc(),
      internalServerError: () => l.internalServerErrorDesc(),
      serviceUnavailable: () => l.serviceUnavailableDesc(),
      requestTimeout: () => l.requestTimeoutDesc(),
      conflict: () => l.conflictDesc(),
      unableToProcess: () => l.unableToProcessDesc(),
      badRequest: (String? reason) {
        return reason ?? l.somethingWhenWrongDesc();
      },
      notFound: (String? reason) => reason ?? l.somethingWhenWrongDesc(),
      unauthorisedRequest: (String? reason) =>
          reason ?? l.somethingWhenWrongDesc(),
      unprocessableEntity: (ErrorResponseMessage? errorResponseMessage) =>
          errorResponseMessage?.message ?? l.somethingWhenWrongDesc(),
    );
  }

  Widget icon() {
    return Image.asset(
    maybeWhen(
        orElse: () => Assets.png.success.path,
        notFound: (_) => Assets.png.success.path,
        serviceUnavailable: () => Assets.png.success.path,
        noInternetConnection: () => Assets.png.success.path,
      ),
    );
  }
}

extension ErrorResponseMessageExtension on ErrorResponseMessage? {
  String? message(String key) {
    return this?.errors?[key]?[0] as String?;
  }

  String parseMessageWhenNull(String key) {
    return this?.errors?[key]?[0] as String? ??
        lookupMessages.somethingWhenWrong();
  }
}