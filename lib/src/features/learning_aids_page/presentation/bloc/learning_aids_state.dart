part of 'learning_aids_bloc.dart';

@freezed
class LearningAidsState with _$LearningAidsState {
  const factory LearningAidsState.initial() = _Initial;
   const factory LearningAidsState.loading() = _Loading;
    const factory LearningAidsState.loaded(List<LearningAidsItem> data) = _Loaded;
     const factory LearningAidsState.error(NetworkExceptions error) = _Error;
}
