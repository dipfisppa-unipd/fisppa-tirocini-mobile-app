import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unipd_mobile/app/app_config.dart';
import 'package:unipd_mobile/controllers/auth_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert' show Codec, base64, base64Decode, utf8;

class ShibbolethWebView extends StatelessWidget {

  final String url;

  const ShibbolethWebView(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Get.back();
            AuthController.to.cancelPolling();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          AuthController.to.cancelPolling();
          return true;
        },
        child: WebView(
          initialUrl: url,
          initialCookies: [],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.clearCache();
          },
          navigationDelegate: (NavigationRequest request) async {
          
            print(request.url);
            if (request.url==AppConfig.SHIBBOLETH_ENDPOINT) 
              Get.back();
          
            return NavigationDecision.navigate;
            
          },
        ),
      ),
    );
     
  }
}
