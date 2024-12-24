import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("copyright Ingles Guru 2025",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500)),
                          
        ),
     
      ],
    );
  }
}