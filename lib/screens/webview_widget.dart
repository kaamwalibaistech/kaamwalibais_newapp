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
        ),
        body: SafeArea(
            child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(url)),
              initialSettings: settings,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {},
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
                // Inject JavaScript to hide the element with class "sticky"
                await controller.evaluateJavascript(source: """
            document.querySelector('.sticky').style.display = 'none';
          """);
                await controller.evaluateJavascript(source: """
            document.querySelector('.city_app_hide').style.display = 'none';
          """);
                await controller.evaluateJavascript(source: """
            var footer = document.querySelector('footer');
            if (footer) {
              footer.style.display = 'none';
            }
          """);
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
