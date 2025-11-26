import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'repository/person_repository.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'views/home_view.dart';
import 'views/profile_view.dart';

import 'services/github_service.dart';
import 'repository/github_repository.dart';
import 'viewmodels/github_viewmodel.dart';
import 'views/github_view.dart';

import 'repository/profile_variant_repository.dart';
import 'viewmodels/profile_variants_viewmodel.dart';
import 'views/profile_variants_view.dart';

import 'viewmodels/theme_viewmodel.dart';
import 'views/map_view.dart';

void main() {
  setUrlStrategy(const HashUrlStrategy()); // для GitHub Pages

  final personRepository = PersonRepository();
  final githubService = GitHubService();
  final githubRepository = GitHubRepository(githubService);
  final profileVariantRepository = ProfileVariantRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel(personRepository)),
        ChangeNotifierProvider(create: (_) => ProfileViewModel(personRepository)),
        ChangeNotifierProvider(create: (_) => GitHubViewModel(githubRepository)),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileVariantsViewModel(profileVariantRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const HomeView(),
        ),
        GoRoute(
          path: '/profile/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ProfileView(id: id);
          },
        ),
        GoRoute(
          path: '/github',
          builder: (_, __) => const GitHubView(),
        ),
        GoRoute(
  path: '/variants',
  builder: (_, __) => const ProfileVariantsView(),
),
        GoRoute(
          path: '/map',
          builder: (_, __) => const MapView(),
        ),
      ],
    );
    

    return Consumer<ThemeViewModel>(
      builder: (context, themeVM, _) {
        return MaterialApp.router(
          title: 'Profile App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.cyan,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: themeVM.currentThemeMode,
          routerConfig: router,
        );
      },
    );
  }
}
