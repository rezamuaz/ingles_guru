import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_mod.freezed.dart';
part 'quiz_mod.g.dart';



@freezed
class QuizMod with _$QuizMod {

  factory QuizMod({
    @JsonKey(name: "lesson_code",defaultValue: "") final String? lessonCode,
    @Default(0) @JsonKey(name: "quiz_id") final int? quizId,
    @Default(0) final int? num,
    @Default("") final String? lang,
    @Default("") final String? context,
    @Default("") final String? question,
    @Default([]) final List<ChoiceMod> selections,
     final String? answer,
     final String? reason
  }) = _QuizMod;

  factory QuizMod.fromJson(Map<String, dynamic> json) => _$QuizModFromJson(json);
}

@freezed
class ChoiceMod with _$ChoiceMod {

  factory ChoiceMod({@Default("") final String? choice, @Default("") final String? description}) = _ChoiceMod;

  factory ChoiceMod.fromJson(Map<String, dynamic> json) => _$ChoiceModFromJson(json);
}


@freezed
class QuizJson with _$QuizJson {

  factory QuizJson({
   @Default([]) final List<QuizMod> result,
   @Default(false) final bool success,
   @Default(0) final int rc
  }) = _QuizJson;

  factory QuizJson.fromJson(Map<String, dynamic> json) => _$QuizJsonFromJson(json);
  
}