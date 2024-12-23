



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sysbit/src/core/common/network_exceptions.dart';
import 'package:sysbit/src/core/common/state_content_type.dart';
import 'package:sysbit/src/core/common/state_wrapper_argument.dart';
import 'package:sysbit/src/core/dialog/state_wrapper_widget.dart';
import 'package:sysbit/src/core/widget/message/en_messages.dart';
import 'package:sysbit/src/core/widget/message/id_messages.dart';
import 'package:sysbit/src/core/widget/message/lookup_messages.dart';

import '../../../gen/assets.gen.dart';
import 'error_response_message.dart';
part 'network_exception_extention.dart';
String _default = 'en';

Map<String, LookupMessages> _lookupMessagesMap = {
  'en': EnMessages(),
  'id': IdMessages(),
};

/// Sets the default [locale]. By default it is `en`.
///
/// Example
/// ```
/// setLocaleMessages('fr', FrMessages());
/// setDefaultLocale('fr');
/// ```
void setDefaultLocale(String locale) {
  assert(_lookupMessagesMap.containsKey(locale),
      '[locale] must be a registered locale');
  _default = locale;
}

/// Sets a [locale] with the provided [lookupMessages] to be available when
/// using the [format] function.
///
/// Example:
/// ```dart
/// setLocaleMessages('fr', FrMessages());
/// ```
///
/// If you want to define locale message implement [LookupMessages] interface
/// with the desired messages
///
void setLocaleMessages(String locale, LookupMessages lookupMessages) {
  _lookupMessagesMap[locale] = lookupMessages;
}

LookupMessages get lookupMessages {
  if (_lookupMessagesMap[_default] == null) {
    if (kDebugMode) {
      print(
        "Locale has not been added, using [$_default] as fallback. To add a locale use [setLocaleMessages]",
      );
    }
  }
  return _lookupMessagesMap[_default] ?? EnMessages();
}

class StateWidget extends StatelessWidget {
  const StateWidget({super.key, required this.args});

  final StateWrapperArgument args;

  static Widget success({
    String? title,
    String? message,
    String? buttonLabel,
    VoidCallback? onButtonTap,
    StateWrapperArgument? args,
  }) {
    return StateWrapperWidget(
      args: (args ??= const StateWrapperArgument()).copyWith(
        title: title ?? args.title ?? lookupMessages.success(),
        description: message ?? args.description,
        buttonLabel: buttonLabel ?? args.buttonLabel ?? lookupMessages.back(),
        onButtonTap: onButtonTap ?? args.onButtonTap,
        iconWidth: args.iconWidth ?? double.infinity,
        icon: Image.asset(
          Assets.png.success.path,
          
        ),
      ),
    );
  }

  static Widget error({
    dynamic error,
    String? title,
    String? message,
    VoidCallback? onRetry,
    StateContentType? stateContentType,
    StateWrapperArgument? args,
    Widget? icon,
  }) {
    if (error is NetworkExceptions) {
      title = title ??= error.message();
      message = message ??= error.messageDescription();
      icon = icon ??= error.icon();
    }

    return StateWrapperWidget(
      args: (args ??= const StateWrapperArgument()).copyWith(
        stateContentType: stateContentType ?? args.stateContentType,
        title: title ?? args.title ?? lookupMessages.somethingWhenWrong(),
        description: message ?? args.description,
        onButtonTap: onRetry ?? args.onButtonTap,
        icon: icon,
      ),
    );
  }

  static Widget noData({
    String? title,
    VoidCallback? onRetry,
    StateWrapperArgument? args,
  }) {
    return StateWrapperWidget(
      args: (args ??= const StateWrapperArgument()).copyWith(
        titlePositionOnTop: true,
        title: title ?? args.title ?? lookupMessages.noData(),
        color: args.color ?? const Color(0xFFADB3BC),
        onButtonTap: onRetry ?? args.onButtonTap,
        icon:  Image.asset(
          Assets.png.success.path,
          
        ),
      ),
    );
  }

  static Widget noResult({
    String? title,
    VoidCallback? onButtonTap,
    StateWrapperArgument? args,
  }) {
    return StateWrapperWidget(
      args: (args ??= const StateWrapperArgument()).copyWith(
        titlePositionOnTop: true,
        title: title ?? args.title ?? lookupMessages.noResult(),
        color: args.color ?? const Color(0xFFADB3BC),
        onButtonTap: onButtonTap ?? args.onButtonTap,
        icon:  Image.asset(
          Assets.png.success.path,
          
        ),
      ),
    );
  }

  static Widget searching({
    String? title,
    VoidCallback? onButtonTap,
    StateWrapperArgument? args,
  }) {
    return StateWrapperWidget(
      args: (args ??= const StateWrapperArgument()).copyWith(
        titlePositionOnTop: true,
        title: title ?? args.title ?? lookupMessages.searching(),
        color: args.color ?? const Color(0xFFADB3BC),
        icon:  Image.asset(
          Assets.png.success.path,
          
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StateWrapperWidget(
      args: args,
    );
  }
}