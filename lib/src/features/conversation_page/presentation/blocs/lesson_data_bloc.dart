import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/conversation_page/data/model/lesson_data.dart';
import 'package:sysbit/src/features/conversation_page/domain/repository/conv_repo.dart';

part 'lesson_data_event.dart';
part 'lesson_data_state.dart';
part 'lesson_data_bloc.freezed.dart';

class LessonDataBloc extends Bloc<LessonDataEvent, LessonDataState> {
  LessonDataBloc() : super(const LessonDataState.initial()) {
    on<LessonDataEvent>((event, emit) async {
      await event.when(
        started: (lessonId) async {
          emit(const LessonDataState.loading());
          final hasConnected = await Network.connection.hasInternetAccess;
          //Check when internet connection enable
          if (hasConnected) {
            final ApiResult<LessonData> apiResult =
                await ConvRepoImpl().getRemote(lessonId);
            apiResult.when(success: (data) async {
              SharedPrefs.instance.setString(
                  "${Keys.jsonPrefixLessonConversation}_$lessonId",
                  jsonEncode(data.toJson()));
              emit(LessonDataState.loaded(data));
            }, failure: (error) async {
              return emit(LessonDataState.error(error));
            });
          } else {
            var cache = SharedPrefs.instance
                .getString("${Keys.jsonPrefixLessonConversation}_$lessonId");
            var data = cache != null? LessonData.fromJson(jsonDecode(cache)) : LessonData();
            return emit(LessonDataState.loaded(data));
          }
        },
      );
    });
  }
}
