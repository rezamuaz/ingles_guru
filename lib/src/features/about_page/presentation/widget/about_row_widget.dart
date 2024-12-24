import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const AboutRowWidget({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w500
                )),
        Text(value,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.w500))
      ],
    );
  }
}

