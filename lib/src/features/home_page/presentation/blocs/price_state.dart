part of 'price_bloc.dart';

@freezed
class PriceState with _$PriceState {
  const factory PriceState.initial() = _Initial;
   const factory PriceState.loading() = _Loading;
    const factory PriceState.loaded(List<Price> data) = _Loaded;
     const factory PriceState.error(NetworkExceptions error) = _Error;
}
