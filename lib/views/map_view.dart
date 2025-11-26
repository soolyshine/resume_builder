import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/map_kharkiv_iframe.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта Харкова'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'), 
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 900,
          height: 600,
          child: MapKharkivIframe(),
        ),
      ),
    );
  }
}
