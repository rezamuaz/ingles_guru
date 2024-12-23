import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/features/root_page/domain/repository/root_repository.dart';

part 'fcm_state.dart';
part 'fcm_cubit.freezed.dart';

class FcmCubit extends Cubit<FcmState> {
  FcmCubit() : super(const FcmState.initial());

  Future<void> updateFcm(String token) async {
    emit(const FcmState.loading());
    try {
      RootRepositoryImpl().updateFcm(token);
      emit(const FcmState.loaded());
    } catch (e) {
      //  emit(FcmState.error());
    }
  }
}
