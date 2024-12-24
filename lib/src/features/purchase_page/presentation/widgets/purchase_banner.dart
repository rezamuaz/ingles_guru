import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/utils/extention.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/payment_bottom.dart';

class PurchaseBanner extends StatelessWidget {
  const PurchaseBanner({super.key, required this.isPremium});
  final bool isPremium;
  @override
  Widget build(BuildContext context) {
    return isPremium
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black87),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text("Ingles Guru Akses Permanen",
                          style: GoogleFonts.inter(
                            letterSpacing: 1.0,
                            fontSize: 16,
                          )),
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Rp. 349.999",
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateTime.fromMillisecondsSinceEpoch(1731656690362)
                            .formatTimeID,
                        style: GoogleFonts.inter(
                            fontSize: 12, fontStyle: FontStyle.italic)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Text("bank transfer",
                          style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(minHeight: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFFFC700)),
                          constraints: const BoxConstraints(minWidth: 20),
                          child: const Icon(Icons.download),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                          
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFFFC700)),
                           
                            child: Text("List Invoice".toUpperCase(),style: GoogleFonts.inter(
                                      
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
          //Free Account
        : Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            splashColor: Colors.white,
            onTap: ()async {
             await showCustomModalBottomSheet(context);
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black87),
                    color: const Color(0xFFFFC700)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DAPATKAN INGLES GURU".toUpperCase(),
                                style: GoogleFonts.inter(
                                    letterSpacing: 1.2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            Text("PREMIUM SEKARANG!".toUpperCase(),
                                style: GoogleFonts.inter(
                                    letterSpacing: 1.2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SvgPicture.asset(
                          Assets.svgs.logo,
                          width: 35,
                          height: 35,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("sekali bayar, akses selamanya!",
                            style: GoogleFonts.inter(
                                fontSize: 12, fontStyle: FontStyle.italic)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Text("Rp. 349.999",
                              style: GoogleFonts.inter(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          ),
        );
  }

  Future<bool?> showCustomModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
      useRootNavigator: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const PaymentBottom();
      },
    );
  }
}
