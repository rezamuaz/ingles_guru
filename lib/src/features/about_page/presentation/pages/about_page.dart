import 'package:flutter/material.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/about_description.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/contacts.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/copyright.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/package_info.dart';
import 'package:sysbit/src/features/common/widget/page_wrapper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const PageWrapper(
        title: "Tentang",
        bodyItem: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: AboutDescription(),
              ),
              Divider(
                color: Colors.black38,
              ),
              PackageInfoWidget(),
              Divider(
                color: Colors.black38,
              ),
              Contacts(),
              Divider(
                color: Colors.black38,
              ),
              Copyright()
            ],
          ),
        ),
      ),
    );
  }
}
