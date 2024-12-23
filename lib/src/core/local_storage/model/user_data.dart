import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {

  factory UserData({
  @Default("") @JsonKey(name: "user_id")  String userid,
  @Default("") @JsonKey(name: "app_id") String appId,
  @Default("") @JsonKey(name: "display_name") String displayName,
  @Default("") @JsonKey(name: "photo_url") String photoUrl,
  @Default("") @JsonKey(name: "email") String email
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}