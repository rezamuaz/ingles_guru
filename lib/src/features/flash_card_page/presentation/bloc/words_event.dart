part of 'words_bloc.dart';

@freezed
class WordsEvent with _$WordsEvent {
  const factory WordsEvent.list({required String lessonCode}) = _List;
  const factory WordsEvent.shuffle({required String lessonCode}) = _Shuffle;
  const factory WordsEvent.learned() = _Learned;
  const factory WordsEvent.unTicked(Word word) = _UnTicked;
  const factory WordsEvent.shuffleLearned() = _ShuffleLearned;
}
