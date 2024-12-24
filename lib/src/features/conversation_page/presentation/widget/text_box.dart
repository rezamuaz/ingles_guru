
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatefulWidget {
   TextBox(
      {super.key, required this.controller, required this.eng,required this.ind }): opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.2,
              1,
              curve: Curves.ease,
            ),
          ),
        ),
        sizeEng = Tween<double>(
          begin: 0,
          end: 15,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              0.2,
              curve: Curves.ease,
            ),
          ),
        ),
        sizeInd = Tween<double>(begin: 0, end: 12).animate(
          
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              0.2,
              curve: Curves.ease,
            ),
          ),
        ),
        sizeDivider = Tween<double>(begin: 0, end: 10).animate(
          
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              0.2,
              curve: Curves.ease,
            ),
          ),
        );
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> sizeEng;
  final Animation<double> sizeInd;
   final Animation<double> sizeDivider;
  final String eng;
  final String ind;
  
  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox>
    {
 
   Widget _buildAnimation(BuildContext context, Widget? child) {
    return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.eng,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.patrickHand(
                        fontSize: widget.sizeEng.value,
                        fontWeight: FontWeight.bold,
                      color: Colors.black26.withOpacity(widget.opacity.value)),
                    ),
                   Divider(
                      height: widget.sizeDivider.value,
                      color: Colors.black26.withOpacity(widget.opacity.value),
                    ),
                   Text(
                              textAlign: TextAlign.center,

                              widget.ind,
                              style: GoogleFonts.inter(fontSize: widget.sizeInd.value,color: Colors.black26.withOpacity(widget.opacity.value)),
                            )
                          ,
                 
                  ],
                );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: widget.controller, builder: _buildAnimation);
  }
}
