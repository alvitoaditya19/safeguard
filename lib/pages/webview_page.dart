import 'package:flutter/material.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewPage extends StatefulWidget {
  @override
  _MyWebViewPageState createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Location | ",
            style: whiteTextStyle,
          ),
          backgroundColor: blueColor,
        ),
        body: Stack(
          children: [
            Container(
              child: WebView(
                key: _key,
                initialUrl: "https://goo.gl/maps/vWv3AmSWaGbaCJyV7",
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ));
  }
}