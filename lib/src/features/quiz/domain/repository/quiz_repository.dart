// ignore: unused_import
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/quiz/data/model/quiz_mod.dart';

abstract class QuizRepository {
  Future<ApiResult<List<QuizMod>>> getQuiz({String? lessonId});
}

class QuizRepositoryImpl implements QuizRepository {
  DioHttp apiService = DioHttp.instance;

  QuizRepositoryImpl();
  @override
  Future<ApiResult<List<QuizMod>>> getQuiz({String? lessonId}) async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
        additionalInterceptors: [AuthInterceptor()],
        "${Env.quizEp}?code=$lessonId",
        onSuccess: (response) => (response.data["result"] as List)
            .map(
              (e) => QuizMod.fromJson(e),
            )
            .toList());
  }
}
