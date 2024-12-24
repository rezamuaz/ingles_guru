import 'package:flutter/material.dart';

class AppBarShape extends OutlinedBorder {
  @override
  OutlinedBorder copyWith({BorderSide? side}) => this; //todo

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(rect.left, rect.bottom -30, rect.width, 30),
        topLeft: const Radius.circular(30),
        topRight: const Radius.circular(30),
      ));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    /// create shader linear gradient
    canvas.drawPath(getInnerPath(rect), Paint()..color = Colors.blue);
  }

  @override
  ShapeBorder scale(double t) => this;
}