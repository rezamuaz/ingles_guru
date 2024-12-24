import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_req.freezed.dart';
part 'register_req.g.dart';

@freezed
class RegisterReqMod with _$RegisterReqMod {
  const factory RegisterReqMod(
      {final String? appId,
      @Default("") @JsonKey(name: "id_token") final String? idToken,
      @Default("") final String? os,
      @Default("") final String? language,
      @Default("")  @JsonKey(name: "fcm_token") final String? fcmToken,
      @Default({})
      @JsonKey(name: "device_info")
      final Map<String, dynamic> deviceInfo}) = _RegisterReqMod;

  factory RegisterReqMod.fromJson(Map<String, dynamic> json) =>
      _$RegisterReqModFromJson(json);
}
