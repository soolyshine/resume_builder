import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableBanner extends StatefulWidget {
  const ClickableBanner({super.key});

  @override
  State<ClickableBanner> createState() => _ClickableBannerState();
}

class _ClickableBannerState extends State<ClickableBanner> {
  bool _isHover = false; 

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: MediaQuery.of(context).size.height / 2 - 100,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final url = Uri.parse('https://www.atbmarket.com/'); 
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              print("Cannot open $url");
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isHover ? 220 : 200,  
            height: _isHover ? 220 : 200,
            decoration: BoxDecoration(
              color: _isHover ? Colors.blue.shade50 : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: _isHover ? 12 : 8,
                  color: Colors.black26,
                ),
              ],
              border: Border.all(
                color: _isHover ? Colors.blueAccent : Colors.black12,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/assets.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
