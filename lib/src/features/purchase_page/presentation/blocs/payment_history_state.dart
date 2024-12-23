part of 'payment_history_bloc.dart';

@freezed
class PaymentHistoryState with _$PaymentHistoryState {
  const factory PaymentHistoryState.initial() = _Initial;
  const factory PaymentHistoryState.loading() = _Loading;
  const factory PaymentHistoryState.loaded(List<PaymentItem> data) = _Loaded;
  const factory PaymentHistoryState.error(NetworkExceptions error) = _Error;
}
