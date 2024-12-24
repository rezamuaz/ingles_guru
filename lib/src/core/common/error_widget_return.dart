import 'package:flutter/material.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';

Widget errorWidget(NetworkExceptions error,{required TextStyle style}) {
  return error.when(
    badRequest: (reason) => Text(reason ?? "",style:style ,),
    unauthorisedRequest: (reason) => Text(reason ?? "",style:style ),
    forbiddenRequest: (reason) => Text(reason ?? "",style:style ),
    notFound: (reason) => Text(reason ?? ""),
    methodNotAllowed: (reason) => Text(reason ?? "",style:style ),
    notAcceptable: (reason) => Text(reason ?? "",style:style ),
    requestTimeout: () =>  Text("request timeout",style:style),
    conflict: () =>  Text("Conflict",style:style),
    unprocessableEntity: (reasons) => Text(reasons!.errors.toString(),style:style),
    internalServerError: () =>  Text("Internal Server Error",style:style),
    serviceUnavailable: () =>  Text("serviceUnavailable",style:style),
    unexpectedError: (reason) =>  Text(reason??"",style:style),
    sendTimeout: () =>  Text("sendTimeout",style:style),
    receiveTimeout: () =>  Text("receiveTimeout",style:style),
    requestCancelled: () =>  Text("requestCancelled",style:style),
    noInternetConnection: () =>  Text("noInternetConnection",style:style),
    certificateFailed: () =>  Text("SSL certificate Failed",style:style),
    notImplemented: () =>  Text("notImplemented",style:style),
    formatException: () =>  Text("formatException",style:style),
    unableToProcess: () =>  Text("unableToProcess",style:style),
    defaultError: (error) =>  Text("",style:style),
  );
}
