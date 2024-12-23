import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/about_row_widget.dart';


class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informasi Kontak",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
       const AboutRowWidget(title:"Email:",value: " inglesguru9@gmail.com"),
        const AboutRowWidget(title:"Instagram:",value: " "),
        const AboutRowWidget(title:"Facebook:",value: " "),
      
      ],
    );
  }
}
