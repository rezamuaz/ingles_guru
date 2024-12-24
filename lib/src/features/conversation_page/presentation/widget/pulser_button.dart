import 'package:flutter/material.dart';

class PulserButton extends StatefulWidget {
  const PulserButton({super.key, this.onPress});
  final void Function()? onPress;

  @override
  State<PulserButton> createState() => _PulserButtonState();
}

class _PulserButtonState extends State<PulserButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat();
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.6, end: 1.3).animate(_controller);
  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 1, end: 0.2).animate(_controller);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 50 * 1.5,
              height: 50 * 1.5,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black26),
            ),
          ),
        ),
        InkWell(
          onTap: widget.onPress,
          child: Container(
            height: 65,
            width: 65,
            
          decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,border: Border.all(color:Colors.black54,width: 2 )),
            child: const Icon(
              Icons.mic,
              size: 50,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );
  }
}
