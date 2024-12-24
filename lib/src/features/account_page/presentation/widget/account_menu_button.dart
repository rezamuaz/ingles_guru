import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcccountMenuButtons extends StatelessWidget {
  const AcccountMenuButtons(this.icon,{super.key,required this.title,required this.onTap });
  final String? title;
  final Widget icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(onPressed: onTap,iconAlignment: IconAlignment.start, label: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title??"",style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.black87),),
        const Icon(Icons.arrow_forward_ios,color: Colors.black87)
      ],
    ),icon: icon);
  }
}