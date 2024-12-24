
import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:sysbit/src/core/common/extend_state.dart';
import 'package:sysbit/src/core/common/state_content_type.dart';
import 'package:sysbit/src/core/common/state_wrapper_argument.dart';
import 'package:sysbit/src/core/constant/constant.dart';

class StateWrapperWidget extends StatelessWidget {
  const StateWrapperWidget({
    super.key,
    required this.args,
  });

  final StateWrapperArgument args;

  @override
  Widget build(BuildContext context) {
    return _isTypeFull
        ? buildContentTypeFull(context)
        : buildContentTypeSection(context);
  }

  bool get _isTypeFull => args.stateContentType == StateContentType.full;

  bool get _isDescriptionNull => args.description == null;

  Widget buildContentTypeSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.kPaddingL),
          child: SizedBox(
            width: args.iconWidth ?? 40,
            child: args.icon ?? const SizedBox(),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitle(context),
              if (!_isDescriptionNull) buildDescription(context),
            ],
          ),
        ),
        if (args.onButtonTap != null) buildButton(context),
      ],
    );
  }

  Widget buildContentTypeFull(BuildContext context) {
    final MediaQueryData m = MediaQuery.of(context);

    return SizedBox(
      height: m.size.height -
          kToolbarHeight -
          kBottomNavigationBarHeight -
          92 -
          Constants.kPaddingXL * 2,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (args.titlePositionOnTop) buildTitle(context),
          SizedBox(
            width: args.iconWidth ?? 175,
            child: args.icon ?? const SizedBox(),
          ),
          if (!args.titlePositionOnTop)
            const SizedBox(height: Constants.kPaddingL),
          if (!args.titlePositionOnTop) buildTitle(context),
          if (!_isDescriptionNull) buildDescription(context),
          const SizedBox(height: Constants.kPaddingXL),
          if (args.onButtonTap != null) buildButton(context),
          const SizedBox(height: Constants.kPaddingXL),
        ],
      ),
    );

    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     if (args.titlePositionOnTop) buildTitle(context),
    //     SizedBox(
    //       width: args.iconWidth ?? 175,
    //       child: args.icon ?? const SizedBox(),
    //     ),
    //     if (!args.titlePositionOnTop)
    //       const SizedBox(height: Constants.kPaddingL),
    //     if (!args.titlePositionOnTop) buildTitle(context),
    //     if (!_isDescriptionNull) buildDescription(context),
    //     const SizedBox(height: Constants.kPaddingXL),
    //     if (args.onButtonTap != null) buildButton(context),
    //     const SizedBox(height: Constants.kPaddingXL),
    //   ],
    // );
  }

  Widget buildDescription(BuildContext context) {
    return _isTypeFull
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.kPaddingXL,
              vertical: Constants.kPaddingS,
            ),
            child: AutoSizeText(
              args.description!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          )
        : Text(
            args.description!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
  }

  Text buildTitle(BuildContext context) {
    double fontSize = _isTypeFull
        ? _isDescriptionNull
            ? Constants.kFontSizeXL
            : Constants.kFontSizeXXL
        : Constants.kFontSizeS;

    return Text(
      args.title ?? '-',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: fontSize,
            color: args.color,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildButton(BuildContext context) {
    if (!_isTypeFull) {
      return IconButton(
        onPressed: args.onButtonTap,
        icon: const Icon(Icons.refresh),
        color: Theme.of(context).primaryColor,
        tooltip: args.buttonLabel ?? lookupMessages.tryAgain(),
      );
    }

    return SizedBox(
      height: Theme.of(context).buttonTheme.height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        onPressed: args.onButtonTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.kPaddingS,
          ),
          child: Text(
            args.buttonLabel ?? lookupMessages.tryAgain(),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}