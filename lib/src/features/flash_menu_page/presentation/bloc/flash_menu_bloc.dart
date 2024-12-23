import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/object_box/progress_repository.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';
import 'package:sysbit/src/features/lessons_starter_page/domain/repository/lesson_repo.dart';

part 'flash_menu_event.dart';
part 'flash_menu_state.dart';
part 'flash_menu_bloc.freezed.dart';

class FlashMenuBloc extends Bloc<FlashMenuEvent, FlashMenuState> {
  final ProgressRepository _progressRepository;
  FlashMenuBloc({required ProgressRepository progressRepository})
      : _progressRepository = progressRepository,
        super(const FlashMenuState()) {
    on<FlashMenuEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(state.copyWith(status: FlashStatus.loading));
          final hasConnected = await Network.connection.hasInternetAccess;
          if (hasConnected) {
            final ApiResult<LessonMod> apiResult =
                await LessonRepoImpl().getStarterLessonRemote();
            return apiResult.when(success: (data) async {
              SharedPrefs.instance
                  .setString(Keys.jsonStarterLesson, jsonEncode(data.toJson()));
              var allowed =
                  await _progressRepository.getAllProgressStream().first;

              if (allowed.isEmpty) {
                return emit(state.copyWith(
                    lessons: data.result, status: FlashStatus.success));
              }

              List<LessonItem> newItems = [];
              for (int index = 0; index < data.result.length; index++) {
                var result = allowed.any(
                    (al) => al.lessonCode == data.result[index].lessonCode);
                if (result) {
                  newItems.add(data.result[index].copyWith(unlocked: true));
                } else {
                  newItems.add(data.result[index].copyWith(unlocked: false));
                }
              }

              return emit(state.copyWith(
                  lessons: newItems, status: FlashStatus.success));
            }, failure: (error) async {
              return emit(
                state.copyWith(
                  status: FlashStatus.error,
                ),
              );
            });
            //When Internet Connection Disable
          } else {
            var dataStr =
                SharedPrefs.instance.getString(Keys.jsonStarterLesson);
            var data = LessonMod.fromJson(jsonDecode(dataStr ?? ""));
            var allowed =
                await _progressRepository.getAllProgressStream().first;
            if (allowed.isEmpty) {
              return emit(state.copyWith(
                  lessons: data.result, status: FlashStatus.success));
            }

            List<LessonItem> newItems = [];
            for (int index = 0; index < data.result.length; index++) {
              var result = allowed
                  .any((al) => al.lessonCode == data.result[index].lessonCode);
              if (result) {
                newItems.add(data.result[index].copyWith(unlocked: true));
              } else {
                newItems.add(data.result[index].copyWith(unlocked: false));
              }
            }
            return emit(state.copyWith(lessons: newItems));
          }
        },
      );
    });
  }

  @override
  void onEvent(FlashMenuEvent event) {
    logger.d(event);
    super.onEvent(event);
  }

  @override
  void onChange(Change<FlashMenuState> change) {
    logger.d(change);
    super.onChange(change);
  }
}
