part of 'lesson_data_bloc.dart';

@freezed
class LessonDataState with _$LessonDataState {
  const factory LessonDataState.initial() = _Initial;
  const factory LessonDataState.loading() = _Loading;
  const factory LessonDataState.loaded(LessonData data ) = _Loaded;
  const factory LessonDataState.error(NetworkExceptions error) = _Error;
}
