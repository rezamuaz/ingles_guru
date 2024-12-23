part of 'fcm_cubit.dart';

@freezed
class FcmState with _$FcmState {
  const factory FcmState.initial() = _Initial;
  const factory FcmState.loading() = _Loading;
  const factory FcmState.loaded() = _Loaded;
  const factory FcmState.error(NetworkExceptions error) = _Error;
}
