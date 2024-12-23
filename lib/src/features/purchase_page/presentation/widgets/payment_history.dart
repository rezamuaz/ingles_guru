
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sysbit/src/core/utils/extention.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/features/payment_page/presentation/pages/payment_page.dart';
import 'package:sysbit/src/features/purchase_page/data/model/payment_item.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory(
      {super.key, required this.purchase, required this.noData});
  final List<PaymentItem> purchase;
  final bool noData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: noData
              ? Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Riwayat Pembayaran",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(child: Text(
                    "Tidak ada data",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(fontSize: 14),
                  ),),
                ))
              ],)
              : Text(
                  "Riwayat Pembayaran",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(fontSize: 16),
                ),
        ),
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: purchase.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemBuilder: (context, index) {
              return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.black87)),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _color(
                            purchase[index].status, purchase[index].expiredAt),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                      ),
                      constraints: const BoxConstraints(minHeight: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              _status(purchase[index].status,
                                  purchase[index].expiredAt),
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                          _icon(
                              purchase[index].status, purchase[index].expiredAt)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Ingles Guru Akses Permanen",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black87,
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Rp. 349.999",
                                style: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            purchase[index].orderId.toString()))
                                    .then((_) {
                                      if(context.mounted){
                                         ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Copied to your clipboard !')));
                                      }
                                 
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    purchase[index].orderId.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: const Icon(
                                      Icons.copy,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  DateTime.fromMillisecondsSinceEpoch(
                                          purchase[index].updatedAt)
                                      .formatTimeID,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic)),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Text(purchase[index].paymentMethod,
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          _showButton(purchase[index].status,
                                  purchase[index].expiredAt)
                              ? SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context,rootNavigator: true).push(Utils.createRoute(PaymentPage(
                                                url: purchase[index]
                                                    .paymentUrl)));
                                      },
                                      style: ButtonStyle(
                                          shape: WidgetStatePropertyAll(
                                              ContinuousRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Colors.black87)),
                                      child: Text(
                                          "Lanjutkan Pembayaran".toUpperCase(),
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold))),
                                )
                              : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ]));
            },
          ),
        ),
      ],
    );
  }

  bool _showButton(String status, int expired) {
    int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    switch (status) {
      case "Belum Bayar":
        if (now >= expired) {
          return false;
        } else {
          return true;
        }
      case "Menunggu":
        return true;
      default:
        return false;
    }
  }

  String _status(String status, int expired) {
    int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    if (status == "Belum Bayar") {
      if (now >= expired) {
        return "Dibatalkan";
      } else {
        return status;
      }
    } else {
      return status;
    }
  }

  Color _color(String val, int expired) {
    int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    switch (val) {
      case "Menunggu":
        return Colors.black38;
      case "Berhasil":
        return Colors.green;
      case "Belum Bayar":
        if (now >= expired) {
          return const Color(0xFFFF4343);
        } else {
          return Colors.black26;
        }
      case "Dibatalkan":
        return const Color(0xFFFF4343);
      default:
        return Colors.black54;
    }
  }

  Widget _icon(String val, int expired) {
    int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    switch (val) {
      case "Menunggu":
        return const Icon(
          Icons.av_timer_sharp,
          color: Colors.white,
        );
      case "Berhasil":
        return const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        );
      case "Belum Bayar":
        if (now >= expired) {
          return const Icon(
            Icons.close,
            color: Colors.white,
          );
        } else {
          return const Icon(
            Icons.payment,
            color: Colors.white,
          );
        }
      case "Dibatalkan":
        return const Icon(
          Icons.close,
          color: Colors.white,
        );
      default:
        return const Icon(
          Icons.close,
          color: Colors.white,
        );
    }
  }
}
