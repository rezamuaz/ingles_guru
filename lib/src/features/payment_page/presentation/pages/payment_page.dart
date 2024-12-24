import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/env/env.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/core/widget/dialog/dialog.dart';
import 'package:sysbit/src/features/purchase_page/presentation/pages/purchase_page.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class PaymentPage extends StatefulWidget {
  final String url;

  const PaymentPage({
    super.key,
    required this.url,
  });

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  String? selectedUrl;
  double value = 0.0;
  bool _isLoading = true;

  late WebViewController _controller;

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
    selectedUrl = widget.url;

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (kDebugMode) {
              debugPrint('WebView is loading (progress : $progress%)');
            }
          },
          onPageStarted: (String url) {
            if (kDebugMode) {
              debugPrint('Page started loading: $url');
            }

            setState(() {
              _isLoading = true;
            });
            if (url.contains(Env.baseUrl)) {
              bool isSuccess = url.contains('success');
              bool isFailed = url.contains('cancel');
              bool isPending = url.contains('unfinish');
              setState(() {
                _isLoading = true;
              });
              if (isSuccess) {
                XDialog.success(
                  context,
                  title: "Selesai",
                  okBtnText: "Tutup",
                  okButton: () {
                    Navigator.of(context).pop();
                  },
                );
                return;
              }

              if (isPending) {
                XDialog.confim(context,
                    title: "Pembayaran Belum Selesai",
                    cancelButton: () {}, okButton: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(Utils.createRoute(const PurchasePage()));
                },
                    description:
                        "silakan periksa kembali di halaman pembayaran");

                return;
              } else if (isFailed) {
                XDialog.success(context,
                    title: "Pembayaran Gagal",
                    okButtonColor: Colors.black87,
                    okBtnText: "Tutup", okButton: () {
                  Navigator.of(context).pop();
                }, description: "Silakan order kembali");
                return;
              }
            }
          },
          onPageFinished: (String url) {
            if (kDebugMode) {
              debugPrint('Page finished loading: $url');
            }

            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            if (kDebugMode) {
              debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  Future<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    bool canNavigate = await _controller.canGoBack();
    if (canNavigate) {
      log(canNavigate.toString());
      _controller.goBack();
      return Future.value(true);
    } else {
      if (context.mounted) {
        XDialog.confim(context, title: "Konfirmasi", cancelButton: () {},
            okButton: () {
          Navigator.of(context).pop();
        }, description: "anda yakin ingin menutup halaman pembayaran?");
      }
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  Future<void> regenerateAccessToken() async {
    var dio = Dio();

    // get refresh token from local storage
    var user = await SharedPrefs.getToken();

    //Get Access Token
    try {
      final response = await dio.put(
        "${Env.baseUrl}${Env.refreshEp}",
        options: Options(
          contentType: "application/json",
        ),
        data: {
          "refresh_token": user?.refreshToken,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final TokenResp result = TokenResp.fromJson(response.data['result']);
        var newUser = user?.copyWith(
            accessToken: result.accessToken ?? "",
            role: result.role ?? [],
            isPremium: true);
        await SharedPrefs.setToken(newUser ?? Token());
        try {
          await dio.patch(
            "${Env.baseUrl}${Env.userStatusEp}",
            options: Options(
              contentType: "application/json",
              headers: {"Authorization": "Bearer ${user?.refreshToken}"},
            ),
            data: {
              "status": true,
            },
          );
        } catch (e) {
          logger.e(e);
        }
      } // save to local storage
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // leading: IconButton(
      //   //     onPressed: () => _exitApp(context),
      //   //     icon: const Icon(Icons.arrow_back)),
      //   // title: const SizedBox(
      //   //   width: double.infinity,
      //   //   child: Text(
      //   //     "Before 24",
      //   //     textAlign: TextAlign.left,
      //   //   ),
      //   // ),
      //   automaticallyImplyLeading: false,
      // ),
      // backgroundColor: Color(0xFFFFC700),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(
                  controller: _controller,
                ),
                _isLoading
                    ? Center(
                        child: LoadingAnimationWidget.twistingDots(
                            leftDotColor: Colors.blue,
                            rightDotColor: Colors.red,
                            size: 50),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
