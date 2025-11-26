import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  final int id;
  const ProfileView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfileViewModel>();
    final person = vm.getPerson(id);

    return Scaffold(
      appBar: AppBar(title: const Text('Мій профіль')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/185949285?v=4', 
                ),
              ),
              const SizedBox(height: 20),

             
              const Text(
                'Soolyshine', // своє ім’я
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              
              Text(
                person.title,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 10),

          
              Text(
                person.description,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

         
              ElevatedButton.icon(
                onPressed: () {
                  context.go('/'); // завжди повертаємось на головну
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Назад'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

