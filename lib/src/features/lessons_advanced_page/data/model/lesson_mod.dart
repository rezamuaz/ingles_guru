import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_mod.freezed.dart';
part 'lesson_mod.g.dart';

@freezed
class LessonMod with _$LessonMod {

  factory LessonMod({
   @Default(LessonItem())  final LessonItem intro,
    @Default([]) List<LessonItem> result 
  }) = _LessonMod;

  factory LessonMod.fromJson(Map<String, dynamic> json) => _$LessonModFromJson(json);
 
}

@freezed
class LessonItem with _$LessonItem {
  
 const factory LessonItem(
      {@Default("") @JsonKey(name: "lesson_code")  final String? lessonCode,
     @Default(0) @JsonKey(name: "lesson_id")  final int? lessonId,
      
    @Default("")  final String? title,
    @Default("") final String? image,
    @Default("") final String? description,
     @Default(0) @JsonKey(name: "updated_at") final int? updatedAt,
     @Default(false) @JsonKey(name: "unlocked")   final bool? unlocked
     
      }) = _LessonItem;
  const LessonItem._();
  factory LessonItem.fromJson(Map<String, dynamic> json) =>
      _$LessonItemFromJson(json);
}
