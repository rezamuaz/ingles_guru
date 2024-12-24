
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:sysbit/src/features/conversation_page/presentation/widget/text_box.dart';

class BubbleBox extends StatefulWidget {
  BubbleBox({
    super.key,
    required this.controller,
    required this.eng,
    required this.ind,
    required this.constrain,
    required this.playAudio,
    this.audioDownlading = false,
    required this.switchDialog,
    this.isLeftAlign = true,
  })  : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        padding = EdgeInsetsTween(
          begin: EdgeInsets.zero,
          end: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.250,
              0.375,
              curve: Curves.ease,
            ),
          ),
        );
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<EdgeInsets> padding;
  final Function()? switchDialog;
  final BoxConstraints constrain;
  final String eng;
  final String ind;
  final bool isLeftAlign;
  final bool audioDownlading;

  ///Play Voice

  final VoidCallback playAudio;

  @override
  State<BubbleBox> createState() => _BubbleBoxState();
}

class _BubbleBoxState extends State<BubbleBox> with TickerProviderStateMixin {
  late AnimationController _controllerText;
  late Animation<double> _opacityIcon;

  Future<void> _playAnimation() async {
    try {
      await _controllerText.forward().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because we were disposed.
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerText = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    widget.controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _playAnimation();
        }
      },
    );
    _opacityIcon = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controllerText,
        curve: const Interval(
          0.2,
          1,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerText.dispose();
    super.dispose();
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Positioned(
      top: widget.constrain.maxHeight * 0.6,
      left: 0,
      right: 0,
      child: Container(
        constraints:
            BoxConstraints(minHeight: widget.constrain.maxHeight * 0.3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection:
              widget.isLeftAlign ? TextDirection.ltr : TextDirection.rtl,
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black54, width: 2)),
                  child: TextBox(
                      controller: _controllerText.view,
                      eng: widget.eng,
                      ind: widget.ind)),
            ),
            Container(
              width: 60,
              // color: Colors.indigo,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controllerText,
                    builder: (context, child) => widget.audioDownlading
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.black26, size: 25)
                        : Transform.rotate(
                              angle: widget.isLeftAlign
                                  ? 0 * (math.pi / 180)
                                  : 180 * (math.pi / 180),
                              child: IconButton.filledTonal(
                                icon: const Icon(Icons.volume_up),
                                onPressed: widget.playAudio,
                                color: Colors.black54
                                    .withOpacity(_opacityIcon.value),
                              ),
                            ),
                  ),
                  AnimatedBuilder(
                    animation: _controllerText,
                    builder: (context, child) => IconButton.filledTonal(
                        onPressed: widget.switchDialog,
                        icon: Icon(
                          Icons.mic,
                          color: Colors.black54.withOpacity(_opacityIcon.value),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller, builder: _buildAnimation);
  }
}
