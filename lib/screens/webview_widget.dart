import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewWidget extends StatefulWidget {
  const WebviewWidget(
      {super.key, required this.appBarTitle, required this.url});
  final String url;
  final String appBarTitle;
  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.appBarTitle),
          actions: [Text("V 2.0.5 (35) (5)   ")],
        ),
        body: SafeArea(
            child: Stack(
          children: [
            InAppWebView(
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  useShouldOverrideUrlLoading: true,
                  clearCache: false,
                ),
                ios: IOSInAppWebViewOptions(
                  allowsInlineMediaPlayback: true,
                ),
              ),
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(url)),
              initialSettings: settings,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) async {
                if (url.toString().contains("contact-us")) {
                  await controller.evaluateJavascript(source: '''
      if (typeof window.jQuery !== "undefined" && typeof jQuery.fn.countUp !== "function") {
        jQuery.fn.countUp = function() {};
      }
    ''');
                }
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                // var uri = navigationAction.request.url!;

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) async {
                // Hide unwanted elements
                await controller.evaluateJavascript(source: """
    var sticky = document.querySelector('.sticky');
    if (sticky) sticky.style.display = 'none';
  """);

                await controller.evaluateJavascript(source: """
    var cityHide = document.querySelector('.city_app_hide');
    if (cityHide) cityHide.style.display = 'none';
  """);

                await controller.evaluateJavascript(source: """
    var footer = document.querySelector('footer');
    if (footer) footer.style.display = 'none';
  """);

                // 🧩 Fix for 'countUp is not a function' issue
                if (url.toString().contains("contact-us")) {
                  await controller.evaluateJavascript(source: '''
      (function() {
        // Wait until jQuery is ready
        if (typeof window.jQuery === "undefined") {
          console.log("⚠️ jQuery not loaded yet.");
        } else {
          if (typeof jQuery.fn.countUp !== "function") {
            console.log("✅ Patching missing countUp...");
            jQuery.fn.countUp = function() {};
          } else {
            console.log("✅ countUp already defined.");
          }
        }
      })();
    ''');
                }
              },
              onReceivedError: (controller, request, error) {},
              onProgressChanged: (controller, progress) {
                if (progress == 100) {}
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                if (kDebugMode) {
                  print(consoleMessage);
                }
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        )));
  }
}
