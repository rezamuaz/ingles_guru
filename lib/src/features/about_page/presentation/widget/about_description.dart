import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';

class AboutDescription extends StatelessWidget {
  const AboutDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 130),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary),
            child: SvgPicture.asset(
              Assets.svgs.logo,
              width: 90,
              height: 90,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Text("INGLES GURU",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}
