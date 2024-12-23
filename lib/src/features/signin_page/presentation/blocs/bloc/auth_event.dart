part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signing(UserAuth user) = _Signing;
  const factory AuthEvent.signout() = _Signout;
  const factory AuthEvent.checking() = _Checking;
}