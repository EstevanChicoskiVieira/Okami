import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Habilitar o JavaScript no WebView
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: 'https://okamisushihouse.com.br',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
          navigationDelegate: (NavigationRequest request) async {
            final url = request.url;
            if (_isExternalLink(url)) {
              await _launchExternalLink(url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  bool _isExternalLink(String url) {
    // Verifica se o URL é externo com base em algum critério, por exemplo, não inicia com 'https://okamisushihouse.com.br'
    return !url.startsWith('https://okamisushihouse.com.br');
  }

  Future<void> _launchExternalLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }
}
