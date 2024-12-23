part of 'quiz_bloc.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loading() = _Loading;
  const factory QuizState.loaded(List<QuizMod> data) = _Loaded;
  const factory QuizState.error(NetworkExceptions error) = _Error;

}
