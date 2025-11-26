import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;

  const Avatar({super.key, required this.url, this.size = 96});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey.shade300,
            child: Icon(Icons.person, size: size * 0.6),
          );
        },
      ),
    );
  }
}
