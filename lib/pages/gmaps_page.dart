// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'dart:ui';

// class GMapsHtml extends StatefulWidget {
//   final String url;
//   const GMapsHtml({super.key, required this.url});
//   @override
//   _GMapsHtmlState createState() => _GMapsHtmlState();
// }

// class _GMapsHtmlState extends State<GMapsHtml> {
//   late Widget iframeWidget;
//   final IFrameElement iframeElement = IFrameElement();
//   @override
//   void initState() {
//     super.initState();
//     iframeElement.height = '100%';
//     iframeElement.width = '100%';
//     iframeElement.src = widget.url;
//     iframeElement.style.border = 'none';
//     ui.platformViewRegistry.registerViewFactory(
//       widget.url,
//       (int viewId) => iframeElement,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HtmlElementView(
//       viewType: widget.url,
//     );
//   }
// }