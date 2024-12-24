import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/lessons_starter_page/data/model/lesson_mod.dart';

abstract class LessonRepo {
  Future<ApiResult<LessonMod>> getStarterLessonRemote();
  Future<ApiResult<LessonMod>> getAdvanceLessonRemote();
}

class LessonRepoImpl implements LessonRepo {
  DioHttp apiService = DioHttp.instance;
  LessonRepoImpl();

  @override
  Future<ApiResult<LessonMod>> getStarterLessonRemote() async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
      additionalInterceptors: [AuthInterceptor()],
      Env.starterLessonEp,
      onSuccess: (response) => LessonMod.fromJson(response.data["result"]),
    );
  }

  @override
  Future<ApiResult<LessonMod>> getAdvanceLessonRemote() async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
      additionalInterceptors: [AuthInterceptor()],
      Env.advanceLessonEp,
      onSuccess: (response) => LessonMod.fromJson(response.data["result"]),
    );
  }
}
