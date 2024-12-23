import 'package:flutter/material.dart';
import 'package:sysbit/src/features/conversation_page/presentation/widget/blob_widget.dart';
import 'dart:math' show pi;
class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  const PlayButton({super.key, 
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Icon(Icons.play_arrow),
    this.pauseIcon = const Icon(Icons.pause),
  });

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(minutes: 20);  
  static const _kRotationDuration = Duration(minutes: 5);

  bool? isPlaying;

  // rotation and scale animations
  AnimationController? _rotationController;
  AnimationController? _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController!.isDismissed;

  void _updateRotation() => _rotation = _rotationController!.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController!.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying!);

    if (_scaleController!.isCompleted) {
      _scaleController!.reverse();
    } else {
      _scaleController!.forward();
    }
	  
    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
          color: Colors.blue.withOpacity(0.5),
          isPlaying: true,
        ),
            // Blob(color: Color.fromARGB(108, 0, 145, 255), scale: _scale, rotation: _rotation * 2 - 30),
            // Blob(color: Color.fromARGB(108, 0, 145, 255), scale: _scale, rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: AnimatedSwitcher(
              duration: _kToggleDuration,
              child: _buildIcon(isPlaying!),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController!.dispose();
    _rotationController!.dispose();
    super.dispose();
  }
}