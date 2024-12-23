part of 'speech_checker_bloc.dart';

@freezed
class SpeechCheckerEvent with _$SpeechCheckerEvent {
  const factory SpeechCheckerEvent.started({String? text}) = _Started;
  const factory SpeechCheckerEvent.check({String? originText,String? lastword}) = _Check;
}