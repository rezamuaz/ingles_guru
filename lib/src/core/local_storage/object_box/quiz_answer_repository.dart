import 'package:sysbit/objectbox.g.dart';
import 'package:sysbit/src/core/local_storage/entities/quiz_answer.dart';
import 'package:sysbit/src/core/local_storage/entities/word.dart';

class QuizAnswerRepository {
  QuizAnswerRepository({required this.store});
  final Store store;

  /// Upsert [QuizAnswer] in the store.
  void addAnswer(QuizAnswer answer) {
    store.box<QuizAnswer>().put(answer, mode: PutMode.put);
  }

  /// Provides a [Stream] of single word.
  Stream<QuizAnswer?> getAnswerStream(int id) {
    final query = store.box<QuizAnswer>().query(QuizAnswer_.id.equals(id));
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
}
