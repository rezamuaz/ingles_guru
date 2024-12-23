import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_auth.freezed.dart';
part 'user_auth.g.dart';

@freezed
class UserAuth with _$UserAuth {

  factory UserAuth({
    final String? sub,
    final String? email,
    final String? name,
    final String? picture,
  }) = _UserAuth;

  factory UserAuth.fromJson(Map<String, dynamic> json) => _$UserAuthFromJson(json);
}