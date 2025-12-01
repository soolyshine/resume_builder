import 'dart:ui_web' as ui;           // <-- правильний імпорт
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web; // замість dart:html

class AdBanner extends StatelessWidget {
  AdBanner({super.key}) {
    ui.platformViewRegistry.registerViewFactory(
      'ad-container',
      (int viewId) {
        // отримуємо HTML елемент через package:web
        return web.document.getElementById('ad-container') as web.HTMLElement;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      child: HtmlElementView(viewType: 'ad-container'),
    );
  }
}
