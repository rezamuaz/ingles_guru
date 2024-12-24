import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/start_button.dart';

class AdvancedPacWidget extends StatelessWidget {
  const AdvancedPacWidget(
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
          onTap: Env.bypassPayment
              ? onTapContent
              : isPremium
                  ? onTapContent
                  : onTapPay,
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
                              top: -265,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                Assets.webp.advancePac.path,
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
                            'ADVANCE PAC'.toUpperCase(),
                            style: GoogleFonts.patrickHand(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.6,
                                color: Colors.black87),
                          ),
                          StartButton(
                            bgColor: Env.bypassPayment
                                ? Theme.of(context).colorScheme.primary
                                : isPremium
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.black87,
                            widget: Text(
                              Env.bypassPayment
                                  ? "Mulai".toUpperCase()
                                  : isPremium
                                      ? "Mulai".toUpperCase()
                                      : "unlock".toUpperCase(),
                              style: GoogleFonts.inter(
                                color: Env.bypassPayment
                                    ? Colors.black87
                                    : isPremium
                                        ? Colors.black87
                                        : Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            callback: Env.bypassPayment
                                ? onTapContent
                                : isPremium
                                    ? onTapContent
                                    : onTapPay,
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
