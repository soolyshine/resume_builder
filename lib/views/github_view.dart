import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/github_viewmodel.dart';

class GitHubView extends StatefulWidget {
  const GitHubView({super.key});

  @override
  State<GitHubView> createState() => _GitHubViewState();
}

class _GitHubViewState extends State<GitHubView> {
  final TextEditingController _controller = TextEditingController(text: 'soolyshine');

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GitHubViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub статистика'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'GitHub username',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    vm.fetchUser(_controller.text.trim());
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (vm.isLoading)
              const CircularProgressIndicator()
            else if (vm.error != null)
              Text('Помилка: ${vm.error}', style: const TextStyle(color: Colors.red))
            else if (vm.user != null)
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(vm.user!.avatarUrl),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      vm.user!.login,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(vm.user!.bio ?? '', textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('Repos', vm.user!.publicRepos),
                        _buildStat('Followers', vm.user!.followers),
                        _buildStat('Following', vm.user!.following),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      // 👇 Плаваюча кнопка по центру знизу
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/'),
        icon: const Icon(Icons.home),
        label: const Text('На головну'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildStat(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
