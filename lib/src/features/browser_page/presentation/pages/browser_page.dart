import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/core/constant/constant.dart';
import 'package:sysbit/src/core/local_storage/model/token.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/core/utils/utils.dart';
import 'package:sysbit/src/core/widget/dialog/dialog.dart';
import 'package:sysbit/src/features/purchase_page/presentation/pages/purchase_page.dart';
import 'package:sysbit/src/features/signin_page/data/model/token_resp.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class BrowserPage extends StatefulWidget {
  final String url;
  final String title;
  const BrowserPage({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  BrowserPageState createState() => BrowserPageState();
}

class BrowserPageState extends State<BrowserPage> {
  String? selectedUrl;
  double value = 0.0;
  bool _isLoading = true;

  late WebViewController _controller;


  @override
  void initState() {

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

  
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
     
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
