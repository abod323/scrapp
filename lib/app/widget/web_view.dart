import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:sacrapapp/app/widget/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustom extends StatefulWidget {
  final String url;
  final String title;

  const WebViewCustom({super.key, required this.url, required this.title});

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  WebViewController? _controller;
  var loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {
        setState(() {
          loading = false;
        });
      },
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
       
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: Text(widget.title,style: robotoBold.copyWith(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      
      ),

    
    
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: loading?
      Center(child: CircularProgressIndicator(),):
      WebViewWidget(controller: _controller!),
    ),
  );
  }
}