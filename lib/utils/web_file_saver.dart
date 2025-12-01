import 'dart:convert';
import 'package:web/web.dart' as web;

class WebFileSaver {
  static void saveTextFile(String filename, String content) {
    final base64Data = base64Encode(utf8.encode(content));
    final dataUrl = 'data:text/plain;base64,$base64Data';

    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = dataUrl;
    anchor.download = filename;
    anchor.style.display = 'none';

    web.document.body!.appendChild(anchor);
    anchor.click();
    anchor.remove();
  }
}
