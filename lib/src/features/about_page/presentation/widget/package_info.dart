import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sysbit/src/features/about_page/presentation/widget/about_row_widget.dart';

class PackageInfoWidget extends StatefulWidget {
  const PackageInfoWidget({super.key});

  @override
  State<PackageInfoWidget> createState() => _PackageInfoWidgetState();
}

class _PackageInfoWidgetState extends State<PackageInfoWidget> {
  PackageInfo info = PackageInfo(
      appName: "-", packageName: "-", version: "-", buildNumber: "-");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Versi Applikasi",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
        FutureBuilder<PackageInfo>(
          initialData: info,
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the Future to complete
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Show an error message if something goes wrong
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If the Future is completed and data is available, display the result
              return Padding(
                padding: const EdgeInsets.only(left: 0, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AboutRowWidget(title:"app ver.",value: " ${snapshot.data?.version}+${snapshot.data?.buildNumber}"),
                   
                   AboutRowWidget(title:"package",value:" ${snapshot.data?.packageName}"),
                   
                   
                  ],
                ),
              );
            } else {
              // Handle the case where there's no data
              return const Text("---");
            }
          },
        ),
      ],
    );
  }

 
}
