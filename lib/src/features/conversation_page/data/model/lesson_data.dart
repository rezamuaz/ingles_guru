import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_data.freezed.dart';
part 'lesson_data.g.dart';

@freezed
class LessonData with _$LessonData {
 const factory LessonData(
      {@JsonKey(name: "scene_url", defaultValue: "") final String? sceneUrl,
      @JsonKey(name: "tutor_url", defaultValue: "") final String? tutorUrl,
      @Default([]) final List<LessonPage> pages}) = _LessonData;

  factory LessonData.fromJson(Map<String, dynamic> json) =>
      _$LessonDataFromJson(json);
}

@freezed
class LessonPage with _$LessonPage {
const  factory LessonPage(
      {
      ///Number of Page Comic
     @Default(0) final int page,
      @Default(0) @JsonKey(name: "page_id") final int pageId,
      ///Step of Page (Normaly 2 Step/Page)
      final List<LessonStep>? steps}) = _LessonPage;

  factory LessonPage.fromJson(Map<String, dynamic> json) =>
      _$LessonPageFromJson(json);
}



@freezed
class LessonStep with _$LessonStep {
 const factory LessonStep({
    @JsonKey(name: "step") final int? step,

    ///English Language Comic Character
    @JsonKey(name: "contents") final LessonContent? contents,
    @JsonKey(name: "assets") final LessonAssets? assets,
  }) = _LessonStep;

  factory LessonStep.fromJson(Map<String, dynamic> json) =>
      _$LessonStepFromJson(json);
}

@freezed
class LessonAssets with _$LessonAssets {
 const factory LessonAssets({
    @JsonKey(name: "image") final String? image,
    @JsonKey(name: "voice") final String? voice,
  }) = _LessonAssets;

  factory LessonAssets.fromJson(Map<String, dynamic> json) =>
      _$LessonAssetsFromJson(json);
}

@freezed
class LessonContent with _$LessonContent {
const  factory LessonContent(
          {@JsonKey(name: "primary_id") final int? primaryId,
          @JsonKey(name: "primary_lang") final String? primaryLang,
          @JsonKey(name: "secondary_id") final int? secondaryId,
          @JsonKey(name: "secondary_lang") final String? secondaryLang}) =
      _LessonContent;

  factory LessonContent.fromJson(Map<String, dynamic> json) =>
      _$LessonContentFromJson(json);
}
