import 'package:dio/dio.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/conversation_page/data/model/lesson_data.dart';

abstract class ConvRepo {
  Future<ApiResult<LessonData>> getRemote(String lessonId);
}

class ConvRepoImpl implements ConvRepo {
  DioHttp apiService = DioHttp.instance;
  ConvRepoImpl();
  @override
  Future<ApiResult<LessonData>> getRemote(String lessonId,
      {String lang = "id"}) async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
      additionalInterceptors: [
        AuthInterceptor(),
      ],
      "${Env.lessonDetailEp}?code=$lessonId",
      options: Options(headers: {"Accept-Language": lang}),
      onSuccess: (json) => LessonData.fromJson(json.data["result"]),
    );
  }
}
