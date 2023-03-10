

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebVeiwScreen extends StatelessWidget {

  String url;
  WebVeiwScreen(this.url);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(),
          body: WebView(initialUrl: url),
      );    
  }
}