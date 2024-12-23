import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/features/home_page/data/model/payment_created.dart';
import 'package:sysbit/src/features/home_page/domain/repository/home_repo.dart';

part 'payment_event.dart';
part 'payment_state.dart';
part 'payment_bloc.freezed.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const _Initial()) {
    on<PaymentEvent>((event, emit) async {
      await event.when(
        started: (type) async {
          emit(const PaymentState.loading());
          final ApiResult<PaymentCreated> apiResult =
              await HomeRepoImpl().createdPaymentRemote({"payment_id": type});
          return apiResult.when(success: (
            data,
          ) async {
            return emit(PaymentState.loaded(data));
          }, failure: (error) async {
            return emit(PaymentState.error(error));
          });
        },
      );
    });
  }
  @override
  void onChange(Change<PaymentState> change) {
    logger.d(change);
    super.onChange(change);
  }

  @override
  void onEvent(PaymentEvent event) {
    logger.d(event);
    super.onEvent(event);
  }
}
