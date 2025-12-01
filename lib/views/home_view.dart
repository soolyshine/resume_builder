import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../viewmodels/home_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import '../widgets/ad_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final persons = vm.persons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Інформація про себе'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => context.read<ThemeViewModel>().toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () => context.go('/github'),
          ),
        ],
      ),

      body: Stack(
        children: [
          // Основний контент
          ListView.builder(
            itemCount: persons.length,
            itemBuilder: (_, index) {
              final person = persons[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.cyan.shade100,
                  child: Text(
                    person.title[0].toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                title: Text(person.title),
                subtitle: Text(
                  person.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context.go('/profile/${person.id}'),
              );
            },
          ),

          // Банер справа по центру
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * 0.3,
            child: AdBanner(),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: 'add_resume',
              onPressed: () => context.go('/variants'),
              icon: const Icon(Icons.add),
              label: const Text('Додати резюме'),
            ),
            FloatingActionButton.extended(
              heroTag: 'githubStats',
              onPressed: () => context.go('/github'),
              icon: const Icon(Icons.code),
              label: const Text('GitHub статистика'),
            ),
            FloatingActionButton.extended(
              heroTag: 'mapKharkiv',
              onPressed: () => context.go('/map'),
              icon: const Icon(Icons.map),
              label: const Text('Карта Харкова'),
            ),
          ],
        ),
      ),
    );
  }
}



