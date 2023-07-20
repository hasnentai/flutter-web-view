import 'package:eat_fit_web/payment.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/payment': (BuildContext context) => const PaymentScreen(),
    }, home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  MyHome({
    super.key,
  });

  late WebViewController _controller;

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late final WebViewController _controller;
  late String myOtherScreeData = "";

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset("assets/web-page-1.html")
      ..addJavaScriptChannel("MessageInvoker", onMessageReceived: (s) async {
        myOtherScreeData = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              message: s.message,
            ),
          ),
        );
        setState(() {});
      });
    _controller = controller;
  }

  Future<void> _onShowUserAgent() {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    return _controller.runJavaScript(
      'MessageInvoker.postMessage("User Agent: " + navigator.userAgent);',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: myOtherScreeData == ""
          ? WebViewWidget(
              controller: _controller,
            )
          : Column(
              children: [
                ElevatedButton(
                  onPressed: _onShowUserAgent,
                  child: Text("Send Message to JS"),
                ),
                Text(myOtherScreeData),
              ],
            ),
    );
  }
}
