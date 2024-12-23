
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sysbit/src/core/common/state_content_type.dart';

part 'state_wrapper_argument.freezed.dart';

@Freezed(copyWith: true)
class StateWrapperArgument with _$StateWrapperArgument {

   const factory StateWrapperArgument({
    Widget? icon,
    double? iconWidth,
    String? title,
    String? description,
    Color? color,
    String? buttonLabel,
    VoidCallback? onButtonTap,
    @Default(false) bool titlePositionOnTop,
    @Default(StateContentType.full) StateContentType stateContentType,
  }) = _StateWrapperArgument;

}