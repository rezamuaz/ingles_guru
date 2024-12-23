part of 'flash_menu_bloc.dart';


enum FlashStatus { initial, loading, success, error }
@freezed
class FlashMenuState with _$FlashMenuState {
   const factory FlashMenuState(
          {@Default([]) List<LessonItem> lessons,
          @Default(FlashStatus.initial) FlashStatus status}) = _FlashMenuState;
}
