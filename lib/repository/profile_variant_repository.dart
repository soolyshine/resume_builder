import '../models/profile_variants.dart';

class ProfileVariantRepository {
  final List<ProfileVariant> _variants = [
    ProfileVariant(
      id: '1',
      title: 'Student',
      summary: 'Навчання на факультаті ІКМ при Університеті ХПІ',
      skills: 'Dart, Flutter, PHP, Python, C++',
      experience: '3 роки створення програм на різних мовах програмування і кросплатформених програм',
    ),
  ];

  List<ProfileVariant> getAll() => List.unmodifiable(_variants);

  void add(ProfileVariant variant) {
    _variants.add(variant);
  }

  void duplicate(String id) {
    final original = _variants.firstWhere((v) => v.id == id);
    final newVariant = ProfileVariant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '${original.title} (копія)',
      summary: original.summary,
      skills: original.skills,
      experience: original.experience,
    );
    _variants.add(newVariant);
  }

  /// 🔹 Оновлення існуючого варіанту
  void update(ProfileVariant updated) {
    final index = _variants.indexWhere((v) => v.id == updated.id);
    if (index != -1) {
      _variants[index] = updated;
    }
  }
}
