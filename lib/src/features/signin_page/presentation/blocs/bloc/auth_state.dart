part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.isAuthorized() = _IsAuthorized;
   
  const factory AuthState.unAuthorized() = _UnAuthorized;
  const factory AuthState.isError(NetworkExceptions error) = _IsError;
}
