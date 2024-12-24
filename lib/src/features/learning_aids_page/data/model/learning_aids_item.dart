import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_aids_item.freezed.dart';
part 'learning_aids_item.g.dart';

@freezed
class LearningAidsItem with _$LearningAidsItem {

  const factory LearningAidsItem({
  @Default(0)  @JsonKey(name: "lesson_id") final int lessonId,
    @Default("") @JsonKey(name: "lesson_code")  final String lessonCode,
   @Default(0)  @JsonKey(name: "file_id")  final int fileId,
   @Default("")  @JsonKey(name: "type")  final String type,
   @Default("")  @JsonKey(name: "url")  final String url
  }) = _LearningAidsItem;

  factory LearningAidsItem.fromJson(Map<String, dynamic> json) => _$LearningAidsItemFromJson(json);
}