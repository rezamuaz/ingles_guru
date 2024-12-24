import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/learning_aids_page/data/model/learning_aids_item.dart';

abstract class LearningAidsRepo {
  Future<ApiResult<List<LearningAidsItem>>> getLeaningAidsRemote(String lessonCode);
}

class LearningAidsRepoImpl implements LearningAidsRepo {
  DioHttp apiService = DioHttp.instance;
  LearningAidsRepoImpl();

  @override
  Future<ApiResult<List<LearningAidsItem>>> getLeaningAidsRemote(String lessonCode) async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
       "${Env.learningAidsEp}?code=$lessonCode&type=la",
      additionalInterceptors: [AuthInterceptor()],
     
      onSuccess: (response) => (response.data["result"] as List)
          .map(
            (e) => LearningAidsItem.fromJson(e),
          )
          .toList(),
    );
  }
}
