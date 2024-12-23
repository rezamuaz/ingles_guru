import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/quiz/data/model/quiz_mod.dart';
import 'package:sysbit/src/features/quiz/domain/repository/quiz_repository.dart';

import '../../../../../core/common/api_result.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';
part 'quiz_bloc.freezed.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState.initial()) {
    on<QuizEvent>((event, emit) async {
      await event.when(
        started: (lessonId) async {
          emit(const QuizState.loading());
          final hasConnected = await Network.connection.hasInternetAccess;
          //When Internet Connection Enable
          if (hasConnected) {
            final ApiResult<List<QuizMod>> apiResult =
                await QuizRepositoryImpl().getQuiz(lessonId: lessonId);

            return apiResult.when(success: (data) async {
              // await HiveService.setJson(
              //     key: "${lessonId}_${Keys.quizSuffix}", value: data);
              SharedPrefs.instance.setString(
                  "${lessonId}_${Keys.quizSuffix}", jsonEncode(data));
              return emit(QuizState.loaded(data));
            }, failure: (error) async {
              return emit(QuizState.error(error));
            });
            //When Internet Connection Disable
          } else {
            var cache = jsonDecode(
                SharedPrefs.instance.get("${lessonId}_${Keys.quizSuffix}") ??
                    "");

            var data = (cache as List).map((e) => QuizMod.fromJson(e)).toList();
            if (data.isEmpty) {
              return emit(const QuizState.error(
                  NetworkExceptions.noInternetConnection()));
            }
            return emit(QuizState.loaded(data));
          }
        },
      );
    });
  }
  @override
  void onChange(Change<QuizState> change) {
    super.onChange(change);
  }
}
