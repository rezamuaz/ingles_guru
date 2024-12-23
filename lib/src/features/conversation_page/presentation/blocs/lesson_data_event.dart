part of 'lesson_data_bloc.dart';

@freezed
class LessonDataEvent with _$LessonDataEvent {
  const factory LessonDataEvent.started({required String lessonId}) = _Started;
}