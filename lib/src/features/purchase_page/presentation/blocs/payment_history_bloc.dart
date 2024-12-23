import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore: unused_import
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/purchase_page/data/model/payment_item.dart';
import 'package:sysbit/src/features/purchase_page/domain/repository/purchase_repo.dart';

part 'payment_history_event.dart';
part 'payment_history_state.dart';
part 'payment_history_bloc.freezed.dart';

class PaymentHistoryBloc
    extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  PaymentHistoryBloc() : super(const _Initial()) {
    on<PaymentHistoryEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(const PaymentHistoryState.loading());
          final hasConnected = await Network.connection.hasInternetAccess;
          //When Internet Connection Enable
          if (hasConnected) {
            final ApiResult<List<PaymentItem>> apiResult =
                await PurchaseRepoImpl().getPaymentRemote();
            return apiResult.when(success: (data) async {
              SharedPrefs.instance
                  .setString(Keys.jsonPaymentHistory, jsonEncode(data));
              return emit(PaymentHistoryState.loaded(data));
            }, failure: (error) async {
              return emit(PaymentHistoryState.error(error));
            });
            //When Internet Connection Disable
          }
          var cache = SharedPrefs.instance.getString(Keys.jsonPaymentHistory);
          var data = (cache as List)
              .map(
                (e) => PaymentItem.fromJson(e),
              )
              .toList();
          return emit(PaymentHistoryState.loaded(data));
        },
      );
    });
  }
}
