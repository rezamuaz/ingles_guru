import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      this.clip = Clip.none,
      this.widget = const Text("Button"),
      this.padding = const EdgeInsets.all(3),
      this.callback,
      this.shape = BoxShape.rectangle,
      this.backgroundColor = Colors.amber,this.radius = const BorderRadius.all(Radius.zero)});
  final Widget widget;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry radius;
  final Function()? callback;
  final BoxShape shape;
  final Color backgroundColor;
  final Clip clip; 
  @override
  Widget build(BuildContext context) {
    return Material(
      
        child: InkWell(
            onTap: callback,
            child: Container(
              clipBehavior: clip,
                decoration: BoxDecoration(shape:shape,color: backgroundColor,borderRadius:radius ),
                child: Padding(
               padding: padding,
                  child: widget,
                ))));
  }
}
