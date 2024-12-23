import 'dart:convert';

import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/auth_interceptor.dart';
import 'package:sysbit/src/core/common/dio_http.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/home_page/data/model/payment_created.dart';
import 'package:sysbit/src/features/home_page/data/model/price.dart';

abstract class HomeRepo {
  Future<ApiResult<PaymentCreated>> createdPaymentRemote(
      Map<String, dynamic> payment);
  Future<ApiResult<List<Price>>> getPrice();
}

class HomeRepoImpl implements HomeRepo {
  DioHttp apiService = DioHttp.instance;
  HomeRepoImpl();

  @override
  Future<ApiResult<PaymentCreated>> createdPaymentRemote(
      Map<String, dynamic> payment) async {
    apiService.configureDio(
      baseUrl: Env.baseUrl,
    );
    return await apiService.postApi(
      data: payment,
      additionalInterceptors: [AuthInterceptor()],
      Env.createPaymentEp,
      onSuccess: (res) => PaymentCreated.fromJson(res.data["result"]),
    );
  }

  @override
  Future<ApiResult<List<Price>>> getPrice() async {
    return await apiService.getApi(
      additionalInterceptors: [AuthInterceptor()],
      Env.paymentPricesEp,
      onSuccess: (response) => (response.data["result"] as List)
          .map(
            (e) => Price.fromJson(e),
          )
          .toList(),
    );
  }
}
