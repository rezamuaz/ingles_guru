import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/start_button.dart';

class ExampPacWidget extends StatelessWidget {
  const ExampPacWidget(
      {super.key, required this.isPremium, this.onTapContent, this.onTapPay});
  final bool isPremium;
  final VoidCallback? onTapContent;
  final VoidCallback? onTapPay;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: isPremium ? onTapContent : onTapPay,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black54, width: 2)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exams Prep".toUpperCase(),
                          style: GoogleFonts.patrickHand(
                            color:  Colors.black87,
                            
                            fontWeight: FontWeight.bold,
                            fontSize: 32
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(maxHeight: 40, minWidth: 60),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.8), // Shadow color with opacity
                                    offset:
                                        const Offset(-2, 2), // Shadow position (x, y)

                                    spreadRadius:
                                        0.5, // How much the shadow spreads
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'IELTS'.toUpperCase(),
                                  style: GoogleFonts.patrickHand(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.6,
                                      color: Colors.black87),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top:
                                              BorderSide(color: Colors.black))),
                                  child: Text(
                                    'TOEFEL'.toUpperCase(),
                                    style: GoogleFonts.patrickHand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.6,
                                        color: Colors.black87),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    const Divider(
                      height: 7,
                    ),
                    Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        width: constraints.maxWidth,
                        Assets.webp.examsPac.path,
                        fit: BoxFit.fill,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Row(
                          //    mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     SvgPicture.asset(
                          //     Assets.svgs.logo,
                          //     height: 12,
                          //     width: 12,
                          //   ),
                            
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: 3),
                          //       child: Text(
                          //         'InglesGuru.com/exam-pac',
                          //         style: GoogleFonts.inter(
                          //             fontSize: 10,
                          //             fontWeight: FontWeight.w400,
                                   
                          //             color: Colors.black87),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          StartButton(
                            bgColor: Colors.white,
                            widget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Kunjungi".toUpperCase(),
                                  style: GoogleFonts.inter(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Icon(
                                  Icons.open_in_new_sharp,
                                  size: 18,
                                )
                              ],
                            ),
                            callback: isPremium ? onTapContent : onTapPay,
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
