
import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/common/extend_state.dart';
import 'package:sysbit/src/core/constant/constant.dart';

class FlashMessageContent extends StatelessWidget {
  const FlashMessageContent({super.key, this.title, required this.message});

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        contents(context),
        bubleIcon(),
        Positioned(
          top: -16,
          left: Constants.kPaddingS,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(Assets.svgs.fail,height: 40,),
             
              Positioned(
                top: 10,
                child: SvgPicture.asset(Assets.svgs.close)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container contents(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFC72C41),
        borderRadius: BorderRadius.circular(Constants.kRadiusL),
      ),
      child: Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Constants.kPaddingS),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? lookupMessages.ohSnap(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: Constants.kPaddingXS * 0.1),
                  AutoSizeText(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: Constants.kFontSizeM,
                        ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned bubleIcon() {
    return Positioned(
      bottom: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.kRadiusL),
        child: SvgPicture.asset(Assets.svgs.bubbles,height: 40,width: 40,)
      ),
    );
  }
}