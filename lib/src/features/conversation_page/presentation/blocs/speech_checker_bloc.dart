
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/features/conversation_page/data/model/text_state.dart';
import 'package:string_similarity/string_similarity.dart';
part 'speech_checker_event.dart';
part 'speech_checker_state.dart';
part 'speech_checker_bloc.freezed.dart';

class SpeechCheckerBloc extends Bloc<SpeechCheckerEvent, SpeechCheckerState> {
  SpeechCheckerBloc() : super(const _Initial()) {
    on<SpeechCheckerEvent>((event, emit) async {
      await event.when(started: (text) async {
        emit(SpeechCheckerState.loaded(
            TextState(text: text, textColor: Colors.black54, init: true)));
      }, check: (origin, lastword) async {
        //waiting status
        emit(const SpeechCheckerState.loading());
        await Future.delayed(const Duration(milliseconds: 1000));
        //Clear text from comma & dot
        String text1 =
            origin!.toLowerCase().replaceAll(RegExp(r'[,.?!:;]'), "");
        String text2 =
            lastword!.toLowerCase().replaceAll(RegExp(r'[,.?!:;]'), "");
        //Checked similarity origin text with recorded result
        if (text1.similarityTo(text2) >= 0.99) {
          //Loaded true result return green color for few second
          emit(SpeechCheckerState.loaded(TextState(
              text: lastword,
              textColor: Colors.green,
              isCorrect: true,
              init: false)));
          await Future.delayed(const Duration(milliseconds: 2000));
          //Loaded result return back color default color
          return emit(SpeechCheckerState.back(TextState(
              text: origin,
              textColor: Colors.green,
              init: false,
              isCorrect: true)));
        } else if (text1.similarityTo(text2) < 0.99) {
          //Loaded false result return red color for few second
          emit(SpeechCheckerState.loaded(TextState(
              text: lastword,
              textColor: Colors.red,
              isCorrect: false,
              init: false)));
          await Future.delayed(const Duration(milliseconds: 2000));
          //Loaded result return back color default color
          return emit(SpeechCheckerState.back(TextState(
              origintext: origin,
              text: lastword,
              textColor: Colors.red,
              init: false,
              isCorrect: false)));
        }
      });
    });
  }
  // @override
  // void onEvent(SpeechCheckerEvent event) {
  //   logger.d(event);
  //   super.onEvent(event);
  // }
  // @override
  // void onChange(Change<SpeechCheckerState> change) {
  //     logger.d(change);
  //   super.onChange(change);
  // }
}
