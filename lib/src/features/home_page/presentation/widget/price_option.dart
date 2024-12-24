import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/core/common/error_widget_return.dart';
import 'package:sysbit/src/core/utils/extention.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/home_page/presentation/blocs/price_bloc.dart';

class PriceOption extends StatelessWidget {
  const PriceOption({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.onValue,
    required this.onPrice
  });

  final Function(String?) onChanged;
  final Function(String?) onValue;
   final Function(int?) onPrice;
  final String groupValue;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => SizedBox(),
          initial: () => SizedBox(),
          loading: () => CircularProgressIndicator(),
          error: (error) =>
              errorWidget(error, style: GoogleFonts.inter(fontSize: 14)),
          loaded: (data) {
            return SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                                return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Utils.getToken(encryptedSharedPreferences).role.contains("starter")? SizedBox.shrink() : Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        listTileTheme: ListTileThemeData(
                          horizontalTitleGap:
                              0, //here adjust based on your need
                        ),
                      ),
                      child: RadioListTile<String>(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 15),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.black87)),
                          title: Text(
                            data[0].name?.toUpperCase() ?? "",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          secondary: Text(
                            "${data[0].price?.toCurrency}",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                          autofocus: true,
                          tileColor: Colors.white,
                          toggleable: true,
                          value: data[0].id ?? "",
                          activeColor: Colors.black87,
                          groupValue: groupValue,
                          onChanged: (value) {
                            onChanged(value);
                            onValue(data[0].id);
                            onPrice(data[0].price);
                          },),
                    ),
                  ),
              //  Padding(
              //       padding: const EdgeInsets.only(top: 3, bottom: 3),
              //       child: Theme(
              //         data: Theme.of(context).copyWith(
              //           listTileTheme: const ListTileThemeData(
              //             horizontalTitleGap:
              //                 0, //here adjust based on your need
              //           ),
              //         ),
              //         child: RadioListTile<String>(
              //             contentPadding:
              //                 const EdgeInsets.only(left: 10, right: 15),
              //             shape:  StadiumBorder(
              //                 side: BorderSide(color: !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Colors.black87 : Colors.black26)),
              //             title: Text(
              //               data[1].name?.toUpperCase() ?? "",
              //               style: GoogleFonts.inter(
              //                   fontSize: 16, fontWeight: FontWeight.w500,color: !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Colors.black87 : Colors.black26),
              //             ),
              //             secondary: Text(
              //               "${data[1].price?.toCurrency}",
              //               style: GoogleFonts.inter(
              //                   fontSize: 16, fontWeight: FontWeight.w500,color: !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Colors.black87 : Colors.black26),
              //             ),
              //             controlAffinity: ListTileControlAffinity.leading,
              //             dense: true,
              //             fillColor: WidgetStatePropertyAll(!Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Colors.black87 : Colors.black26),
              //             autofocus: true,
              //             tileColor: Colors.white,
              //             toggleable: true,
              //             value: data[1].id ?? "",
              //             activeColor: !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Colors.black87 : Colors.black26,
              //             groupValue: groupValue,
              //             onChanged: (value) {
              //               !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? onChanged(value) : (){};
              //             },),
              //       ),
              //     ),
                 !Utils.getToken(encryptedSharedPreferences).role.contains("advance") && Utils.getToken(encryptedSharedPreferences).role.contains("starter")? Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        listTileTheme: const ListTileThemeData(
                          horizontalTitleGap:
                              0, //here adjust based on your need
                        ),
                      ),
                      child: RadioListTile<String>(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 15),
                          shape:  StadiumBorder(
                              side: BorderSide(color:  Colors.black87 )),
                          title: Text(
                            data[1].name?.toUpperCase() ?? "",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black87),
                          ),
                          secondary: Text(
                            "${data[1].price?.toCurrency}",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500,color:  Colors.black87),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          dense: true,
                         
                          autofocus: true,
                          tileColor: Colors.white,
                          toggleable: true,
                          value: data[1].id ?? "",
                          activeColor: Colors.black87,
                          groupValue: groupValue,
                          onChanged: (value) {
                            onChanged(value);
                            onValue(data[1].id);
                             onPrice(data[1].price);
                          },),
                    ),
                  ): SizedBox(),
                 Utils.getToken(encryptedSharedPreferences).role.contains("starter") || Utils.getToken(encryptedSharedPreferences).role.contains("advance")  ? SizedBox.shrink() : Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        listTileTheme: const ListTileThemeData(
                          horizontalTitleGap:
                              0, //here adjust based on your need
                        ),
                      ),
                      child: RadioListTile<String>(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 15),
                          shape: StadiumBorder(
                              side: BorderSide(color:    Colors.black87 )),
                          title: Text(
                            data[2].name?.toUpperCase() ?? "",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          secondary: Text(
                            "${data[2].price?.toCurrency}",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          subtitle: Text(
                            "(${data[0].name?.toUpperCase()}+${data[1].name?.toUpperCase()})",
                            style: GoogleFonts.inter(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          dense: true,
                          autofocus: true,
                          tileColor: Colors.white,
                          toggleable: true,
                          value: data[2].id ?? "",
                          activeColor: Colors.black87,
                          groupValue: groupValue,
                          onChanged:(value) {
                            onChanged(value);
                            onValue(data[2].id);
                             onPrice(data[2].price);
                          }, ),
                    ),
                  )
                ]);
                              });
          },
        );
      },
    );
  }
}
