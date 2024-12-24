import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/common/api_result.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/network/network.dart';
import 'package:sysbit/src/features/learning_aids_page/data/model/learning_aids_item.dart';
import 'package:sysbit/src/features/learning_aids_page/domain/learning_aids_repo.dart';

part 'learning_aids_event.dart';
part 'learning_aids_state.dart';
part 'learning_aids_bloc.freezed.dart';

class LearningAidsBloc extends Bloc<LearningAidsEvent, LearningAidsState> {
  LearningAidsBloc() : super(const LearningAidsState.initial()) {
    on<LearningAidsEvent>((event, emit) async {
      await event.when(
        started: (lessonCode) async {
          emit(const LearningAidsState.loading());
          final hasConnected = await Network.connection.hasInternetAccess;
          //Check when internet connection enable
          if (hasConnected) {
            final ApiResult<List<LearningAidsItem>> apiResult =
                await LearningAidsRepoImpl().getLeaningAidsRemote(lessonCode);
            return apiResult.when(success: (
              data,
            ) async {
               SharedPrefs.instance.setString(
                  "${Keys.jsonPrefixLearningAids}_$lessonCode",
                  jsonEncode(data));
              return emit(LearningAidsState.loaded(data));
            }, failure: (error) async {
              return emit(LearningAidsState.error(error));
            });
          } else {
            var cache = SharedPrefs.instance
                .getString("${Keys.jsonPrefixLearningAids}_$lessonCode");
            List<LearningAidsItem> data = cache != null
                ? (jsonDecode(cache) as List).map((e) => LearningAidsItem.fromJson(e),).toList()
                : [];
            if (data.isEmpty) {
                return emit(LearningAidsState.error(NetworkExceptions.noInternetConnection())) ;    
            }else{
              return emit(LearningAidsState.loaded(data)) ;
            }
            
          }
        },
      );
    });
  }

  @override
  void onChange(Change<LearningAidsState> change) {
  logger.d(change);
    super.onChange(change);
  }
}
