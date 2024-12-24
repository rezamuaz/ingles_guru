import 'package:sysbit/objectbox.g.dart';
import 'package:sysbit/src/core/local_storage/entities/word.dart';

class WordRepository {
  WordRepository({required this.store});
  final Store store;

  /// Add [Word] in the store.
  void addWords(List<Word> words) {
    store.box<Word>().putMany(words, mode: PutMode.put);
  }

  /// Update [Word] with the given.
  void updateWord(Word word) {
    store.box<Word>().put(word, mode: PutMode.put);
  }

  /// Update [Word] with the given.
  void delWord(Word word) {
    store.box<Word>().remove(word.id);
  }

  /// Provides a [Stream] of all words.
  Stream<List<Word>> getAllWordStreamByLesson(String lessonCode) {
    final query = store.box<Word>().query(Word_.lessonCode.equals(lessonCode));
    return query
        .watch(triggerImmediately: true)
        .map<List<Word>>((query) => query.find());
  }

  /// Provides a [Stream] of single word.
  Stream<Word?> getWordStream(int id) {
    final query = store.box<Word>().query(Word_.id.equals(id));
    // return query.stream();
    return query.watch(triggerImmediately: true).map((query) {
      final result = query.find();

      return result.isNotEmpty ? result.first : null;
    });
  }

  /// Provides a [Stream] of all words.
  Stream<List<Word>> getAllWordStreamDone() {
    final query = store.box<Word>().query(Word_.tick.equals(true));
    return query
        .watch(triggerImmediately: true)
        .map<List<Word>>((query) => query.find());
  }

  /// Provides a [Stream] of all words.
  Stream<List<Word>> getAllWordStream() {
    final query = store.box<Word>().query();
    return query
        .watch(triggerImmediately: true)
        .map<List<Word>>((query) => query.find());
  }
}
