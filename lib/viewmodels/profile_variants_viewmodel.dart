import 'package:flutter/material.dart';
import '../models/profile_variants.dart';
import '../repository/profile_variant_repository.dart';

class ProfileVariantsViewModel extends ChangeNotifier {
  final ProfileVariantRepository repository;

  ProfileVariantsViewModel(this.repository);

  List<ProfileVariant> get variants => repository.getAll();

  void addNew(ProfileVariant variant) {
    repository.add(variant);
    notifyListeners();
  }

  void duplicateVariant(String id) {
    repository.duplicate(id);
    notifyListeners();
  }

  /// 🔹 Оновлення резюме
  void updateVariant(ProfileVariant updated) {
    repository.update(updated);
    notifyListeners();
  }
}

