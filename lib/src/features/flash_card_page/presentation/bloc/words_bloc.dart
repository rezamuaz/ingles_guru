import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/local_storage/entities/word.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/local_storage/object_box/word_repository.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/flash_card_page/data/model/flash_card_mod.dart';
import 'package:sysbit/src/features/flash_card_page/domain/repository/flash_card_repo.dart';

part 'words_event.dart';
part 'words_state.dart';
part 'words_bloc.freezed.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final WordRepository _wordRepository;
  final ProgressRepository _progressRepository;
  WordsBloc(
      {required WordRepository wordRepository,
      required ProgressRepository progressRepository})
      : _wordRepository = wordRepository,
        _progressRepository = progressRepository,
        super(const WordsState()) {
    on<WordsEvent>((event, emit) async {
      await event.when(
        list: (lessonCode) async {
          emit(state.copyWith(status: WordsStateStatus.loading));
          final hasConnected = await Network.connection.hasInternetAccess;
          if (hasConnected) {
            final ApiResult<List<FlashCardItem>> apiResult =
                await FlashCardRepoImpl().getRemote(lessonCode);
            return apiResult.when(success: (data) async {
              var local = await _wordRepository
                  .getAllWordStreamByLesson(lessonCode)
                  .first;
              //Prevent update data when exist
              if (local.isNotEmpty) {
                final existingIds = Set<int>.from(local.map((word) => word.id));
                final existingWords = Set<String>.from(local
                    .map((word) => word.word)
                    .where((word) => word != null));
                List<Word> wordSq = [];
                for (var word in data) {
                  final words = word.words['text'] as String?;
                  if (words != null &&
                      !existingIds.contains(word.wordId) &&
                      !existingWords.contains(word.words.toString())) {
                    wordSq.add(Word(
                        id: word.wordId,
                        lessonId: word.lessonId,
                        lessonCode: word.lessonCode,
                        word: jsonEncode(word.words)));
                  }
                }
                _wordRepository.addWords(wordSq);
                await emit.forEach<List<Word>>(
                  _wordRepository.getAllWordStreamByLesson(lessonCode),
                  onData: (words) => state.copyWith(
                    status: WordsStateStatus.success,
                    words: words,
                  ),
                  onError: (_, __) => state.copyWith(
                    status: WordsStateStatus.error,
                  ),
                );
              } else {
                List<Word> wordSq = [];
                for (var word in data) {
                  wordSq.add(Word(
                      id: word.wordId,
                      lessonId: word.lessonId,
                      lessonCode: word.lessonCode,
                      word: jsonEncode(word.words)));
                }
                _wordRepository.addWords(wordSq);
                _progressRepository.addProgress(lessonCode, flash: true);
                await emit.forEach<List<Word>>(
                  _wordRepository.getAllWordStreamByLesson(lessonCode),
                  onData: (words) => state.copyWith(
                    status: WordsStateStatus.success,
                    words: words,
                  ),
                  onError: (_, __) => state.copyWith(
                    status: WordsStateStatus.error,
                  ),
                );
              }
            }, failure: (error) {
              return state.copyWith(
                status: WordsStateStatus.error,
              );
            });
          }

          await emit.forEach<List<Word>>(
            _wordRepository.getAllWordStreamByLesson(lessonCode),
            onData: (words) => state.copyWith(
              status: WordsStateStatus.success,
              words: words,
            ),
            onError: (_, __) => state.copyWith(
              status: WordsStateStatus.error,
            ),
          );
        },
        shuffle: (lessonCode) async {
          emit(state.copyWith(status: WordsStateStatus.loading));
          await emit.forEach(
            _wordRepository.getAllWordStreamByLesson(lessonCode),
            onData: (words) {
              final random = Random();
              List<Word> reshuffled = List.from(words);
              reshuffled.shuffle(random);
              return state.copyWith(
                  status: WordsStateStatus.success, words: reshuffled);
            },
            onError: (_, __) => state.copyWith(
              status: WordsStateStatus.error,
            ),
          );
        },
        learned: () async {
          emit(state.copyWith(status: WordsStateStatus.loading));
          await emit.forEach(
            _wordRepository.getAllWordStream(),
            onData: (words) {
              return state.copyWith(
                  status: WordsStateStatus.success, words: words);
            },
            onError: (_, __) => state.copyWith(
              status: WordsStateStatus.error,
            ),
          );
        },
        unTicked: (word) async {
          emit(state.copyWith(status: WordsStateStatus.loading));
          _wordRepository.updateWord(word.copyWith(tick: false));
          emit(state.copyWith(
              words: state.words
                  .where((chooseWord) => chooseWord.id != word.id)
                  .toList(),
              status: WordsStateStatus.success));
        },
        shuffleLearned: () async {
          emit(state.copyWith(status: WordsStateStatus.loading));
          await emit.forEach(
            _wordRepository.getAllWordStream(),
            onData: (words) {
              final random = Random();
              List<Word> reshuffled = List.from(words);
              reshuffled.shuffle(random);
              return state.copyWith(
                  status: WordsStateStatus.success, words: reshuffled);
            },
            onError: (_, __) => state.copyWith(
              status: WordsStateStatus.error,
            ),
          );
        },
      );
    });
  }
}
