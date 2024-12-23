import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/core/common/error_widget_return.dart';
import 'package:sysbit/src/core/utils/extention.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/home_page/presentation/blocs/payment_bloc.dart';
import 'package:sysbit/src/features/home_page/presentation/blocs/price_bloc.dart';
import 'package:sysbit/src/features/home_page/presentation/widget/price_option.dart';
import 'package:sysbit/src/features/payment_page/presentation/pages/payment_page.dart';

class PaymentBottom extends StatefulWidget {
  const PaymentBottom({super.key});

  @override
  State<PaymentBottom> createState() => _PaymentBottomState();
}

class _PaymentBottomState extends State<PaymentBottom> {
  bool term = false;
   String? selectedOption = '';
   String? onValue;
   int? onPrice;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentBloc(),
        ),
        BlocProvider(
          create: (context) => PriceBloc()..add(PriceEvent.started()),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (data) {
                Navigator.pop(context);
                Navigator.of(context, rootNavigator: true)
                    .push(Utils.createRoute(PaymentPage(
                  url: data.paymentUrl,
                )));
              },
              error: (error) {},
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Title Pembayaran
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                    Text(
                      "Pembayaran".toUpperCase(),
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Flexible(
                //       flex: 1,
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.only(left: 2, right: 8),
                //             child: Text(
                //               "•",
                //               style: TextStyle(fontSize: 20),
                //             ),
                //           ),
                //           Flexible(
                //             child: Text("Ingles Guru Akses Permanen",
                //                 textAlign: TextAlign.left,
                //                 style: GoogleFonts.inter(
                //                   fontSize: 16,
                //                 )),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //         child: Text("Rp. 349.999",
                //             textAlign: TextAlign.right,
                //             style: GoogleFonts.inter(
                //               fontSize: 16,
                //             )))
                //   ],
                // ),
                PriceOption(
                  onPrice: (p0) {
                    setState(() {
                      onPrice = p0;
                    });
                  },onValue: (p0) {
                  setState(() {
                    onValue = p0;
                  });
                },groupValue: selectedOption??"", onChanged: (p0) {
                  selectedOption = p0;
                  setState(() {  
                  });
                },),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "pembayaran ini tidak bisa di refund dan di batalkan",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: Colors.black45)),
                ),
                const Divider(
                  color: Colors.black45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                        )),
                    onPrice != null? Expanded(
                        child: Text("${onPrice?.toCurrency}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.bold))): Expanded(child: SizedBox())
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListTileTheme(
                    horizontalTitleGap: 0,
                    child: CheckboxListTile(
                        checkColor: Colors.green,
                        fillColor: const WidgetStatePropertyAll(Colors.white),
                        contentPadding: EdgeInsets.zero,
                        checkboxShape: const CircleBorder(),
                        side: const BorderSide(color: Colors.black54),
                        value: term,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? value) {
                          setState(() {
                            term = value!;
                          });
                        },
                        title: Semantics(
                          excludeSemantics: true,
                          label: "Setuju dengan",
                          child: RichText(
                            text: TextSpan(
                                text: "Setuju dengan",
                                style: GoogleFonts.inter(
                                    fontSize: 14, color: Colors.black54),
                                children: <TextSpan>[
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: GoogleFonts.inter(
                                          fontSize: 14, color: Colors.blue),
                                      text: "syarat dan ketentuan"),
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                      style: GoogleFonts.inter(
                                          fontSize: 14, color: Colors.black54),
                                      text: "InglesGuru")
                                ]),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black87)),
                      onPressed: () {
                        if (!term) return;
                        if(onValue == null ) return;
                        context
                            .read<PaymentBloc>()
                            .add(PaymentEvent.started(onValue??""));
                      },
                      child: BlocBuilder<PaymentBloc, PaymentState>(
                        builder: (context, state) {
                          return state.when(
                            initial: () => Text("Selanjutnya".toUpperCase(),
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            loaded: (data) => Text("Selanjutnya".toUpperCase()),
                            error: (error) => errorWidget(error,
                                style: GoogleFonts.inter(
                                    fontSize: 14, color: Colors.white)),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
