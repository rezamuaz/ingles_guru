import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/purchase_page/data/model/payment_item.dart';

abstract class PurchaseRepo {
  Future<ApiResult<List<PaymentItem>>> getPaymentRemote();
}

class PurchaseRepoImpl implements PurchaseRepo {
  DioHttp apiService = DioHttp.instance;
  PurchaseRepoImpl();

  @override
  Future<ApiResult<List<PaymentItem>>> getPaymentRemote() async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.getApi(
      additionalInterceptors: [AuthInterceptor()],
      Env.paymentHistoryEp,
      onSuccess: (response) => (response.data["result"] as List)
          .map(
            (e) => PaymentItem.fromJson(e),
          )
          .toList(),
    );
  }
}
