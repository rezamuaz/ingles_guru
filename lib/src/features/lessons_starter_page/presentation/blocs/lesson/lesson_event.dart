part of 'lesson_bloc.dart';

@freezed
class LessonEvent with _$LessonEvent {
  const factory LessonEvent.starterPack() = _StarterPac;
  const factory LessonEvent.advancePack() = _AdvancePac;
}