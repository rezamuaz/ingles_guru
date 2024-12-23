import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key,required this.url,required this.title});
  final String url;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 10,),
                    Text(title,style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    );
  }
}