import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/main.dart';
import 'package:sysbit/src/core/widget/dialog/dialog.dart';
import 'package:sysbit/src/features/common/widget/page_wrapper.dart';
import 'package:sysbit/src/features/preference_page/presentation/widget/custom_input_dialog.dart';

class PreferencePage extends StatelessWidget {
  const PreferencePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: PageWrapper(
          title: "Pengaturan",
          bodyItem: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bahasa",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500)),
                    CountryCodePicker(
                      padding: const EdgeInsets.all(0),
                      showDropDownButton: true,
                      onChanged: (element) => debugPrint(element.code),
                      initialSelection: 'ID',
                      showCountryOnly: true,
                      countryFilter: const ["ID"],
                      showOnlyCountryWhenClosed: true,
                      favorite: const ['+62', 'ID'],
                      hideSearch: true,
                      hideMainText: false,
                      showFlagDialog: true,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Akun",
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500)),
                    TextButton.icon(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 8)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xFFFF0004))),
                      onPressed: () {
                        XDialog.confim(context, title: "HAPUS AKUN!",
                            okButton: () {
                          _confim(context,
                              okButtonColor: Colors.red,
                              okBtnText: "KONFIRMASI HAPUS",
                              title: "HAPUS AKUN!",
                              okButton: () {},
                              cancelButton: () {},
                              cancelButtonColor: Colors.black87);
                        },
                            cancelButton: () {},
                            customDesc: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Semantics(
                                excludeSemantics: true,
                                label: "Setuju dengan",
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text:
                                          "Apakah anda yakin ingin menghapus akun anda?",
                                      style: GoogleFonts.inter(
                                          fontSize: 14, color: Colors.black54),
                                      children: <TextSpan>[
                                        const TextSpan(text: ' '),
                                        TextSpan(
                                            style: GoogleFonts.inter(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold),
                                            text:
                                                "dengan menghapus akun semua akses Ingles Guru akan hilang secara permanen")
                                      ]),
                                ),
                              ),
                            ));
                      },
                      label: const Text("Hapus Akun"),
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _confim(BuildContext context,
      {required String title,
      String? okBtnText = "YA",
      String? cancelBtnText = "TIDAK",
      String? description,
      Widget? customDesc,
      required VoidCallback okButton,
      required VoidCallback cancelButton,
      Color okButtonColor = Colors.green,
      Color cancelButtonColor = Colors.red}) {
    showDialog(
      context: context,
      builder: (_) => CustomeInputDialog(
        okButtonColor: okButtonColor,
        cancelButtonColor: cancelButtonColor,
        singleButton: false,
        onCancel: cancelButton,
        onSubmit: okButton,
        customDesc: customDesc,
        title: title,
        description: description,
        okBtnText: okBtnText,
        cancelBtnText: cancelBtnText,
      ),
    );
  }
}
