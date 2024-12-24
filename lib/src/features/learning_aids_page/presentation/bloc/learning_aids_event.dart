part of 'learning_aids_bloc.dart';

@freezed
class LearningAidsEvent with _$LearningAidsEvent {
  const factory LearningAidsEvent.started(String lessonCode) = _Started;
}