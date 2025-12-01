import 'dart:convert';
import 'dart:typed_data';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

class WebFileSaver {
  static void saveTextFile(String filename, String content) {
    final bytes = Uint8List.fromList(utf8.encode(content));

    // Створюємо чистий JSUint8Array
    final jsUint8 = bytes.toJS;

    // Створюємо чистий JSArray<BlobPart>
    final jsParts = <web.BlobPart>[jsUint8].toJS;

    // Створюємо Blob (тепер типи абсолютно сумісні)
    final blob = web.Blob(
      jsParts,
      web.BlobPropertyBag(type: 'text/plain'),
    );

    final url = web.URL.createObjectURL(blob);

    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = url;
    anchor.download = filename;
    anchor.style.display = 'none';

    web.document.body!.appendChild(anchor);
    anchor.click();

    anchor.remove();
    web.URL.revokeObjectURL(url);
  }
}
