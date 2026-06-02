import 'package:flutter/material.dart';
import 'package:learnex/core/constants/api_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatelessWidget {
  static const String paymobWebViewRoute = '/paymobWebView';
  final String clientSecret;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  const PaymobWebView({
    super.key,
    required this.clientSecret,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                // Paymob redirects to your redirection_url on completion
                if (request.url.contains('google.com')) {  // ← your redirection_url
                  if (request.url.contains('success=true')) {
                    onSuccess();
                  } else {
                    onFailure();
                  }
                  Navigator.pop(context);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse('https://accept.paymob.com/unifiedcheckout/?publicKey=${ApiConstants.paymobPublicKey}&clientSecret=$clientSecret'),
          ),
      ),
    );
  }
}