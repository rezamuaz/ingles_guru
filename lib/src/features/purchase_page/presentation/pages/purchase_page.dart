import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/gen/assets.gen.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/purchase_page/presentation/blocs/payment_history_bloc.dart';
import 'package:sysbit/src/features/purchase_page/presentation/widgets/account_status_widget.dart';
import 'package:sysbit/src/features/purchase_page/presentation/widgets/payment_history.dart';
import 'package:sysbit/src/features/purchase_page/presentation/widgets/purchase_banner.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentHistoryBloc()..add(const PaymentHistoryEvent.started()),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.amber,
            body: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.logo,
                          width: 45,
                          height: 45,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'PEMBAYARAN',
                                style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2),
                              ),
                              Text(
                                'English on the GO',
                                style: GoogleFonts.inter(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, top: 10, right: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(15, 15),
                              topRight: Radius.elliptical(15, 15)),
                          color: Colors.white),
                      child: RefreshIndicator(
                        onRefresh: () async => context
                            .read<PaymentHistoryBloc>()
                            .add(const PaymentHistoryEvent.started()),
                        child: ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            const SizedBox(height: 15),
                            //Account Status
                             SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                            return AccountStatusWidget(
                                        isPremium:
                                            Utils.getToken(encryptedSharedPreferences).isPremium);}),
                        
                            const SizedBox(height: 10),
                            SharedBuilder(
                          listenKeys: const {"auth"}, //Optional
                          builder: (EncryptedSharedPreferences
                                  encryptedSharedPreferences,
                              String? updatedKey) {
                            return PurchaseBanner(
                                        isPremium:
                                            Utils.getToken(encryptedSharedPreferences).isPremium);}),

                            const SizedBox(height: 10),
                            BlocBuilder<PaymentHistoryBloc,
                                PaymentHistoryState>(
                              builder: (context, state) {
                                return state.when(
                                  initial: () => const SizedBox(),
                                  loading: () => const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  loaded: (data) {
                                    return PaymentHistory(
                                      noData: data.isEmpty,
                                      purchase: data,
                                    );
                                  },
                                  error: (error) => const SizedBox(),
                                );
                              },
                            )
                          ],
                        ),
                      )),
                )
              ],
            ));
      }),
    );
  }
}
