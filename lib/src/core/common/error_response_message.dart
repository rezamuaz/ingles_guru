import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_message.freezed.dart';
part 'error_response_message.g.dart';

@freezed
class ErrorResponseMessage with _$ErrorResponseMessage {
  factory ErrorResponseMessage({
    String? message,
    Map<String, dynamic>? errors,
  }) = _ErrorResponseMessage;

  factory ErrorResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseMessageFromJson(json);
}
