import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/start_button.dart';

class StartedPacWidget extends StatelessWidget {
  const StartedPacWidget({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    //    final List<String> startPacDesc = [
    //   "Sounds",
    //   "Nouns",
    //   "Singular & Plural",
    //   "Adjectives",
    //   "Verbs",
    //   "Pronouns",
    //   "Adverbs",
    //   "Conjunctions",
    //   "Prepositions",
    //   "Interjections",
    //   "Punctuations",
    //   "Present Tense",
    //   "Past Tense",
    //   "Future Tense",
    //   "Numbers",
    //   "Units of Time",
    //   "Subject & Verb Agreement",
    //   "Noun & Pronoun Agreement",
    //   "Article",
    //   "Colors & Units of Measure"
    // ];
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black54, width: 2)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Positioned(
                              top: -370,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                Assets.webp.starterPac.path,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'STARTER PAC'.toUpperCase(),
                            style: GoogleFonts.patrickHand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.6,
                                color: Colors.black87),
                          ),
                          StartButton(
                            bgColor: Theme.of(context).colorScheme.primary,
                            widget: Text(
                              "Mulai".toUpperCase(),
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            callback: onTap,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
