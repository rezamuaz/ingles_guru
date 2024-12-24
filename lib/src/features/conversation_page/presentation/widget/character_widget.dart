import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import 'package:sysbit/src/core/local_storage/cache/cache.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/bubble_box.dart';

class CharacterWidget extends StatefulWidget {
  const CharacterWidget(
      {super.key,
      required this.image,
      this.eng = "",
      this.ind = "",
      this.isLeftAlign = true,
      this.lastWord = "",
      this.voiceUrl = "",
      this.switchDialog});
  final String image;
  final String eng;
  final String ind;
  final bool isLeftAlign;
  final String lastWord;
  final String voiceUrl;
  final Function()? switchDialog;

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool audioDownloading = false;
  late AudioPlayer player = AudioPlayer();
  double _heightWidget({String eng = "", String ind = ""}) {
    double heightInd = 30;
    double heightEng = 30;
    if (eng.length >= 25) {
      heightEng = (eng.length / 25).round() * 30;
    }
    if (ind.length >= 20) {
      heightInd = (ind.length / 20).round() * 25;
    }

    return heightInd + heightEng + 16;
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because we were disposed.
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAnimation();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          widget.isLeftAlign ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.35,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxHeight: constraints.maxHeight * 0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: widget.isLeftAlign
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topCenter,
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.4),
                        child: CachedNetworkImage(
                          imageUrl: widget.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                              child: Icon(
                            Icons.error,
                            size: 32,
                          )),
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                    )
                  ],
                ),
              ),
              BubbleBox(
                  switchDialog: widget.switchDialog,
                  constrain: constraints,
                  audioDownlading: audioDownloading,
                  playAudio: () async {
                    await player.dynamicSet(url: widget.voiceUrl);
                    player.play();
                  },
                  isLeftAlign: widget.isLeftAlign,
                  controller: _controller.view,
                  eng: widget.eng,
                  ind: widget.ind)
            ],
          );
        }),
      ),
    );
  }
}
