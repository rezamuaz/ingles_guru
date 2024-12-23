part of 'lesson_bloc.dart';

@freezed
class LessonState with _$LessonState {
  const factory LessonState.initial() = _Initial;
  const factory LessonState.loading() = _Loading;
  const factory LessonState.loaded(LessonMod data) = _Loaded;
  const factory LessonState.error(NetworkExceptions error) = _Error;
}
