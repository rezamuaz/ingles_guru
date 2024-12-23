import 'dart:math';

import 'package:flutter/material.dart';

class Blob extends StatefulWidget {
  final Color color;
  final bool isPlaying;

  const Blob({
    super.key,
    required this.color,
    required this.isPlaying,
  });

  @override
  _BlobState createState() => _BlobState();
}

class _BlobState extends State<Blob> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  double topLeftRadiusX = 20;
  double topLeftRadiusY = 20;
  double topRightRadiusX = 20;
  double topRightRadiusY = 20;
  double bottomLeftRadiusX = 20;
  double bottomLeftRadiusY = 20;
  double bottomRightRadiusX = 20;
  double bottomRightRadiusY = 20;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addListener(() {
      setState(() {
        if (widget.isPlaying) {
          _updateRadii();
        }
      });
    });
  }

  void _updateRadii() {
    // Randomly change the radii to create a "blob" effect
    topLeftRadiusX = _randomRadius();
    topLeftRadiusY = _randomRadius();
    topRightRadiusX = _randomRadius();
    topRightRadiusY = _randomRadius();
    bottomLeftRadiusX = _randomRadius();
    bottomLeftRadiusY = _randomRadius();
    bottomRightRadiusX = _randomRadius();
    bottomRightRadiusY = _randomRadius();
  }

  double _randomRadius() {
    return Random().nextDouble() * 30 + 10; // Random radius between 10 and 40
  }

  @override
  void didUpdateWidget(Blob oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scaleAnimation.value,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(topLeftRadiusX, topLeftRadiusY),
            topRight: Radius.elliptical(topRightRadiusX, topRightRadiusY),
            bottomRight: Radius.elliptical(bottomRightRadiusX, bottomRightRadiusY),
            bottomLeft: Radius.elliptical(bottomLeftRadiusX, bottomLeftRadiusY),
          ),
        ),
      ),
    );
  }
}