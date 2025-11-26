import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/profile_variants_viewmodel.dart';
import '../models/profile_variants.dart';

class ProfileVariantsView extends StatefulWidget {
  const ProfileVariantsView({super.key});

  @override
  State<ProfileVariantsView> createState() => _ProfileVariantsViewState();
}

class _ProfileVariantsViewState extends State<ProfileVariantsView> {
  void _showAddDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final summaryCtrl = TextEditingController();
    final skillsCtrl = TextEditingController();
    final expCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Створити нове резюме'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Заголовок')),
              TextField(controller: summaryCtrl, decoration: const InputDecoration(labelText: 'Опис')),
              TextField(controller: skillsCtrl, decoration: const InputDecoration(labelText: 'Навички')),
              TextField(controller: expCtrl, decoration: const InputDecoration(labelText: 'Досвід')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Скасувати')),
          ElevatedButton(
            onPressed: () {
              final newVariant = ProfileVariant(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleCtrl.text.isNotEmpty ? titleCtrl.text : 'Без назви',
                summary: summaryCtrl.text,
                skills: skillsCtrl.text,
                experience: expCtrl.text,
              );
              context.read<ProfileVariantsViewModel>().addNew(newVariant);
              Navigator.pop(context);
            },
            child: const Text('Зберегти'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProfileVariant variant) {
    final titleCtrl = TextEditingController(text: variant.title);
    final summaryCtrl = TextEditingController(text: variant.summary);
    final skillsCtrl = TextEditingController(text: variant.skills);
    final expCtrl = TextEditingController(text: variant.experience);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Редагувати резюме'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Заголовок')),
              TextField(controller: summaryCtrl, decoration: const InputDecoration(labelText: 'Опис')),
              TextField(controller: skillsCtrl, decoration: const InputDecoration(labelText: 'Навички')),
              TextField(controller: expCtrl, decoration: const InputDecoration(labelText: 'Досвід')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Скасувати')),
          ElevatedButton(
            onPressed: () {
              final updated = ProfileVariant(
                id: variant.id,
                title: titleCtrl.text,
                summary: summaryCtrl.text,
                skills: skillsCtrl.text,
                experience: expCtrl.text,
              );
              context.read<ProfileVariantsViewModel>().updateVariant(updated);
              Navigator.pop(context);
            },
            child: const Text('Зберегти зміни'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveToFile(ProfileVariant variant) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${variant.title.replaceAll(' ', '_')}.txt');

      final content = '''
Резюме: ${variant.title}

Опис:
${variant.summary}

Навички:
${variant.skills}

Досвід:
${variant.experience}
''';

      await file.writeAsString(content);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Файл збережено: ${file.path}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Помилка збереження: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileVariantsViewModel>();
    final variants = vm.variants;

    return Scaffold(
      appBar: AppBar(title: const Text('Варіанти резюме')),
      body: variants.isEmpty
          ? const Center(child: Text('Немає жодного резюме. Створи нове!'))
          : ListView.builder(
              itemCount: variants.length,
              itemBuilder: (_, index) {
                final variant = variants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(variant.title),
                    subtitle: Text(variant.summary, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Редагувати',
                          onPressed: () => _showEditDialog(context, variant),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          tooltip: 'Дублювати',
                          onPressed: () => vm.duplicateVariant(variant.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.save),
                          tooltip: 'Зберегти як .txt',
                          onPressed: () => _saveToFile(variant),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: 'add_resume',
              onPressed: () => _showAddDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Додати резюме'),
            ),
            FloatingActionButton.extended(
              heroTag: 'go_home',
              backgroundColor: Colors.cyan,
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('На головну'),
            ),
          ],
        ),
      ),
    );
  }
}



