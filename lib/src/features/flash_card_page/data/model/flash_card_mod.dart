import 'package:freezed_annotation/freezed_annotation.dart';

part 'flash_card_mod.freezed.dart';
part 'flash_card_mod.g.dart';


@freezed
class FlashCardMod with _$FlashCardMod {

  factory FlashCardMod({
   @Default([]) final List<FlashCardItem> result
  }) = _FlashCardMod;

  factory FlashCardMod.fromJson(Map<String, dynamic> json) => _$FlashCardModFromJson(json);
 
}

@freezed
class FlashCardItem with _$FlashCardItem {

  factory FlashCardItem({
   @Default("") @JsonKey(name:"lesson_code") final String lessonCode,
  @Default(0) @JsonKey(name:"lesson_id")  final int lessonId,
   @Default(0) @JsonKey(name:"word_id") final int wordId,
  @Default(0) @JsonKey(name:"num")  final int num,
  @Default(false) final bool done,
  @Default({}) @JsonKey(name:"words")  final Map<String,dynamic> words


  }) = _FlashCardItem;

  factory FlashCardItem.fromJson(Map<String, dynamic> json) => _$FlashCardItemFromJson(json);
}

