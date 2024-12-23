import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/features/home_page/data/model/price.dart';
import 'package:sysbit/src/features/home_page/domain/repository/home_repo.dart';

part 'price_event.dart';
part 'price_state.dart';
part 'price_bloc.freezed.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  PriceBloc() : super(const PriceState.initial()) {
    on<PriceEvent>((event, emit) async {
      await event.when(
        started: () async {
          emit(const PriceState.loading());
          final ApiResult<List<Price>> apiResult =
              await HomeRepoImpl().getPrice();
          return apiResult.when(success: (
            data,
          ) async {
            return emit(PriceState.loaded(data));
          }, failure: (error) async {
            return emit(PriceState.error(error));
          });
        },
      );
    });
  }
}
