part of 'speech_checker_bloc.dart';

@freezed
class SpeechCheckerState with _$SpeechCheckerState {
  const factory SpeechCheckerState.initial() = _Initial;
  const factory SpeechCheckerState.loading() = _Loading;
  const factory SpeechCheckerState.loaded(TextState data) = _Loaded;
  const factory SpeechCheckerState.back(TextState data) = _Back;
}
