import 'dart:convert';

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/local_storage/key_storage/key_storage.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/advanced_pac_widget.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/examp_pac_widget.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/payment_bottom.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/starter_pac_widget.dart';
import 'package:sysbit/src/features/lessons_advanced_page/presentation/pages/lessons_advanced_page.dart';
import 'package:sysbit/src/features/lessons_starter_page/presentation/pages/starter_lessons_page.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final collapsedBarHeight = 60.0;
  final expandedBarHeight = 400.0;
  bool isPremium = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Column(
          children: [
            Container(
              // decoration:
              //     BoxDecoration(color: Theme.of(context).colorScheme.primary),
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.logo,
                          height: 57,
                          width: 57,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'INGLES GURU',
                              style: GoogleFonts.inter(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2),
                            ),
                            Text(
                              'English on the GO',
                              style: GoogleFonts.patrickHand(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Material(
                elevation: 10,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(20, 20),
                    topRight: Radius.elliptical(20, 20)),
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 5),
                    // height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(15, 15),
                            topRight: Radius.elliptical(20, 20)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        StartedPacWidget(
                          onTap: () {
                            Navigator.push(context,
                                Utils.createRoute(const StarterLessonsPage()));
                          },
                        ),

                        //  const SizedBox(height: 15),

                        SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                            return AdvancedPacWidget(
                              isPremium: Utils.getToken(encryptedSharedPreferences)
                                  .role.contains("advance"),
                              onTapPay: () async {
                                await showCustomModalBottomSheet(context);
                              },
                              onTapContent: () async {
                                Navigator.of(context).push(
                                    Utils.createRoute(const LessonsAdvancedPage()));
                              },
                            );
                          },
                        ),
                        // const SizedBox(height: 15),
                        Expanded(child: SizedBox())

                        // ExampPacWidget(
                        //   isPremium: true,
                        //   onTapPay: ()  {

                        //   },
                        //   onTapContent: () async {

                        //   },
                        // ),
                      ],
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }



  // Function to show the modal bottom sheet

  Future<bool?> showCustomModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
      useRootNavigator: true,
      isDismissible: false,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const PaymentBottom();
      },
    );
  }
}
