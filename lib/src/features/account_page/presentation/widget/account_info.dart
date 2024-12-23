import 'package:cached_network_image/cached_network_image.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/core/utils/utils.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.black54)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SharedBuilder(
                          listenKeys: const {"user"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                            return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Utils.getUser(encryptedSharedPreferences).photoUrl.isNotEmpty
                        ? CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                                Utils.getUser(encryptedSharedPreferences).photoUrl),
                          )
                        : const CircularProgressIndicator(),
                    const SizedBox(
                      height: 5,
                    ),
                    Utils.getUser(encryptedSharedPreferences).displayName.isNotEmpty
                        ? Text(
                             Utils.getUser(encryptedSharedPreferences).displayName.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 21, fontWeight: FontWeight.w800),
                          )
                        : const CircularProgressIndicator(),
                  ],
                );}),
         
          Text(
            "JOINED SINCE 30 JULY 2024",
            style: GoogleFonts.inter(fontSize: 10, fontStyle: FontStyle.italic),
          ),
        
          Container(
            padding: const EdgeInsets.only(top: 15,bottom: 10),
             
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "STATUS AKUN",
                      style: GoogleFonts.inter(
                          fontSize: 7, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                    child: SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                                return Text(
                     Utils.getToken(encryptedSharedPreferences).role.contains("advance") ||  Utils.getToken(encryptedSharedPreferences).role.contains("starter")? "MEMBER":"GUEST",
                      style: GoogleFonts.inter(
                          fontSize: 12, fontWeight: FontWeight.bold,letterSpacing: 1.1),
                    );
                              } )
                  )
                ],
              ))
          // Container(
          //   height: 45,
          //   decoration: const BoxDecoration(
          //       border:
          //           Border(top: BorderSide(width: 1, color: Colors.black54))),
          //   child:
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 3),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               Text(
          //                 "TIME SPENT",
          //                 style: GoogleFonts.inter(fontSize: 8),
          //               ),
          //               Text("1 Hour",
          //                   style: GoogleFonts.inter(
          //                     height: 0.5,
          //                       fontSize: 9, fontWeight: FontWeight.w700)),
          //               Text("26 Minutes",
          //                   style: GoogleFonts.inter(
          //                       fontSize: 9, fontWeight: FontWeight.w700))
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 3),
          //           decoration:
          //               const BoxDecoration(border: Border(left: BorderSide(width: 1),right: BorderSide(width: 1))),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //              mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               Text(
          //                 "SUBCRIPTION TIER",
          //                 style: GoogleFonts.inter(fontSize: 8),
          //               ),
          //               Container(
          //                 padding: const EdgeInsets.symmetric(horizontal: 8),
          //                 decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     border: Border.all(color: Colors.black87),
          //                     borderRadius: BorderRadius.circular(10)),
          //                 child: Text(
          //                   "SILVER",
          //                   style: GoogleFonts.inter(
          //                       fontSize: 16, fontWeight: FontWeight.w700),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //              mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               Text(
          //                 "OVERALL PROGRESSION",
          //                 style: GoogleFonts.inter(fontSize: 8 ),
          //               ),
          //               Text("25%",
          //                   style: GoogleFonts.inter(
          //                       fontSize: 18, fontWeight: FontWeight.w700)),

          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
