import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountStatusWidget extends StatelessWidget {
  const AccountStatusWidget({super.key,required this.isPremium});
  final bool  isPremium;
  @override
  Widget build(BuildContext context) {
    return Row(
                        children: [
                          Text(
                            'Status Akun:',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                       isPremium?   Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFFFC700)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(
                              "Premium".toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ):Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Text(
                              "Gratis".toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ) 

                        ],
                      );
  }
}