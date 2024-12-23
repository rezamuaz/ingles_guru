part of 'words_bloc.dart';

enum WordsStateStatus { initial, loading, success, error }

@freezed
class WordsState with _$WordsState {
  const factory WordsState(
          {@Default([]) List<Word> words,
          @Default(WordsStateStatus.initial) WordsStateStatus status}) =
      _WordsState;
  factory WordsState.initial() =>
      const WordsState(status: WordsStateStatus.initial, words: []);
}
