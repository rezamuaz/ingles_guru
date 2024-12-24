import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartButton extends StatelessWidget {
  const StartButton(
      {super.key, this.callback, required this.bgColor, required this.widget});
  final VoidCallback? callback;

  final Color bgColor;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback,
        child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width *
                  0.25, // Set the minimum width here
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.8), // Shadow color with opacity
                offset: Offset(-2, 2), // Shadow position (x, y)

                spreadRadius: 0.5, // How much the shadow spreads
              ),
            ], color: bgColor, borderRadius: BorderRadius.circular(15)),
            child: widget));
  }
}
