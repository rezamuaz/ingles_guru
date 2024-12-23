import 'package:objectbox/objectbox.dart';

@Entity()
class Word {
  @Id(assignable: true)
  int id = 0;
  int? lessonId;
  String? lessonCode;
  String? word;
  bool tick = false;
  bool learned = false;

  Word(
      {this.lessonId,
      this.tick = false,
      this.learned = false,
      this.word,
      this.lessonCode,
      required this.id});
  // copyWith method
  Word copyWith({
    int? id,
    int? lessonId,
    String? lessonCode,
    String? word,
    bool? tick,
    bool? learned
  }) {
    return Word(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      lessonCode: lessonCode ?? this.lessonCode,
      word: word ?? this.word,
      tick: tick ?? this.tick,
      learned: learned ?? this.learned
    );
  }
}
