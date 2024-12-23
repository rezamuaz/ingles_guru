import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
class Token with _$Token {

  factory Token({
@Default([]) List<String> role,
@Default(false) @JsonKey(name: "is_premium") bool isPremium,
@Default("") @JsonKey(name: "access_token")  String accessToken,
@Default("") @JsonKey(name: "refresh_token")  String refreshToken,
@Default(0) @JsonKey(name: "access_expire_at")  int accessExpiredAt,
@Default(0) @JsonKey(name: "refresh_expire_at")  int refreshExpiredAt
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}