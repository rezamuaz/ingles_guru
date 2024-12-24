import 'package:objectbox/objectbox.dart';

@Entity()
class QuizAnswer {
  @Id(assignable: true)
  int id = 0;
  String lessonCode;
  String? answer;
  int number;
  bool isCorrect;
  QuizAnswer(
      {required this.isCorrect,
      required this.number,
      this.answer,
      required this.lessonCode,
      required this.id});
  // copyWith method
  QuizAnswer copyWith({
    int? id,
    int? lessonId,
    String? lessonCode,
    String? answer,
    int? number,
    bool? isCorrect,
  }) {
    return QuizAnswer(
      id: id ?? this.id,
      lessonCode: lessonCode ?? this.lessonCode,
      answer: answer ?? this.answer,
      number: number ?? this.number,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
