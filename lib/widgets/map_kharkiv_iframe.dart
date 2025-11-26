import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;          // <-- НОВИЙ ПРАВИЛЬНИЙ ІМПОРТ
import 'package:web/web.dart' as web;

class MapKharkivIframe extends StatelessWidget {
  MapKharkivIframe({super.key}) {
    ui_web.platformViewRegistry.registerViewFactory(
      'kharkiv-map-iframe',
      (int viewId) {
        final iframe = web.HTMLIFrameElement();

        iframe.src =
            'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2564.9949792494015!2d36.23038331571516!3d49.99349997941486!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4127a0fc0b91eef7%3A0xbe648cb0bae0267a!2sKharkiv!5e0!3m2!1sen!2sua!4v1700000000000';

        iframe.style.border = '0';
        iframe.style.width = '100%';
        iframe.style.height = '100%';
        iframe.style.borderRadius = '8px';

        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(viewType: 'kharkiv-map-iframe');
  }
}

