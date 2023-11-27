// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LoandsNew extends StatelessWidget {
  final String lodans;

  const LoandsNew({Key? key, required this.lodans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          bottom: false,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(lodans)),
          ),
        ),
   
    );
  }
}
