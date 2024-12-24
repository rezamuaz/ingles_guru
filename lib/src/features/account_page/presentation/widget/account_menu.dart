import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/about_page/presentation/pages/about_page.dart';
import 'package:sysbit/src/features/account_page/data/repository/account_repository.dart';
import 'package:sysbit/src/features/account_page/presentation/pages/page_info.dart';
import 'package:sysbit/src/features/account_page/presentation/widget/account_menu_button.dart';
import 'package:sysbit/src/features/preference_page/presentation/pages/preference_page.dart';
import 'package:sysbit/src/features/browser_page/presentation/pages/browser_page.dart';
import 'package:sysbit/src/features/purchase_page/presentation/pages/purchase_page.dart';
import 'package:sysbit/src/features/signin_page/presentation/blocs/bloc/auth_bloc.dart';

class AccountMenu extends StatefulWidget {
  const AccountMenu({super.key, required this.color});
  final Color color;

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AcccountMenuButtons(onTap: () {
          Navigator.of(context)
              .push(Utils.zoomOutPageRoute(const PreferencePage()));
        }, Icon(Icons.person_outlined, color: widget.color),
            title: "Pengaturan"),
        // AcccountMenuButtons(onTap: () {
        //   Navigator.of(context).push(Utils.createRoute(const PurchasePage()));
        // }, Icon(Icons.payment, color: widget.color), title: "Pembayaran"),
        AcccountMenuButtons(
            onTap: () {},
            Icon(Icons.bug_report_outlined, color: widget.color),
            title: "Laporan & Saran"),
        AcccountMenuButtons(onTap: () async {
          if (Platform.isAndroid) {
            Navigator.of(context, rootNavigator: true).push(
                Utils.zoomOutPageRoute(BrowserPage(
                    title: "Kebijakan Privasi",
                    url: "${Env.baseUrl}${Env.privacyPolicyEp}?os=android")));
          }
           if (Platform.isIOS) {
            Navigator.of(context, rootNavigator: true).push(
                Utils.zoomOutPageRoute(BrowserPage(
                    title: "Kebijakan Privasi",
                    url: "${Env.baseUrl}${Env.privacyPolicyEp}?os=ios")));
          }
        }, Icon(Icons.privacy_tip_outlined, color: widget.color),
            title: "Kebijakan Privasi"),
        AcccountMenuButtons(onTap: () async {
          if (Platform.isAndroid) {
            Navigator.of(context, rootNavigator: true).push(
                Utils.zoomOutPageRoute(BrowserPage(
                    title: "Syarat & Ketentuan",
                    url: "${Env.baseUrl}${Env.termConditionsEp}?os=android")));
          }
          if (Platform.isIOS) {
            Navigator.of(context, rootNavigator: true).push(
                Utils.zoomOutPageRoute(BrowserPage(
                    title: "Syarat & Ketentuan",
                    url: "${Env.baseUrl}${Env.termConditionsEp}?os=ios")));
          }
        }, Icon(Icons.description_outlined, color: widget.color),
            title: "Syarat & Ketentuan"),
        // AcccountMenuButtons(
        //     onTap: () {},
        //     Icon(Icons.help_outline_outlined,color:widget.color),
        //     title: "Help"),
        AcccountMenuButtons(onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(Utils.zoomOutPageRoute(const AboutPage()));
        }, Icon(Icons.person_outlined, color: widget.color), title: "Tentang"),
        AcccountMenuButtons(onTap: () {
          BlocProvider.of<AuthBloc>(context).add(const AuthEvent.signout());
        }, Icon(Icons.logout_outlined, color: widget.color), title: "Keluar"),
      ],
    );
  }
}
