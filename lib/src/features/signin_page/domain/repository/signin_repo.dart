import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/features/signin_page/data/model/register_req.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';


abstract class SigninRepo {
  Future<ApiResult<TokenResp>> register(RegisterReqMod req);
  Future<ApiResult<TokenResp>> retrivedToken(String refreshToken);
}
