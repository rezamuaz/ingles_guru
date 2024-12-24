import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_state.freezed.dart';

@freezed
class TextState with _$TextState {
  factory TextState(
      {final String? origintext,
        final String? text,
      final Color? textColor,
      @Default(false) final bool isCorrect,
      @Default(false) final bool init}) = _TextState;
}
