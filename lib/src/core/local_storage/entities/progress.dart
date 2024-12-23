import 'package:objectbox/objectbox.dart';

@Entity()
class Progress {
    @Id(assignable: false)
    Progress({
        this.id = 0,
        required this.lessonCode,
        required this.conversation,
        required this.tutorial,
        required this.quiz,
        required this.flash,
        required this.lesson,
    });

    int id;
    final String? lessonCode;
    final bool? conversation;
    final bool? tutorial;
    final bool? quiz;
    final bool? flash;
    final bool? lesson;

    Progress copyWith({
        int? id,
        String? lessonCode,
        bool? conversation,
        bool? tutorial,
        bool? quiz,
        bool? flash,
        bool? lesson,
    }) {
        return Progress(
            id: id ?? this.id,
            lessonCode: lessonCode ?? this.lessonCode,
            conversation: conversation ?? this.conversation,
            tutorial: tutorial ?? this.tutorial,
            quiz: quiz ?? this.quiz,
            flash: flash ?? this.flash,
            lesson: lesson ?? this.lesson,
        );
    }

    factory Progress.fromJson(Map<String, dynamic> json){ 
        return Progress(
            id: json["id"],
            lessonCode: json["lesson_code"],
            conversation: json["conversation"],
            tutorial: json["tutorial"],
            quiz: json["quiz"],
            flash: json["flash"],
            lesson: json["lesson"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_code": lessonCode,
        "conversation": conversation,
        "tutorial": tutorial,
        "quiz": quiz,
        "flash": flash,
        "lesson": lesson,
    };

    @override
    String toString(){
        return "$id, $lessonCode, $conversation, $tutorial, $quiz, $flash, $lesson, ";
    }
}

