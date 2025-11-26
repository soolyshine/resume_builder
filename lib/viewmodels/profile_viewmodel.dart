import 'package:flutter/material.dart';
import '../repository/person_repository.dart';
import '../models/person.dart';

class ProfileViewModel extends ChangeNotifier {
  final PersonRepository repository;

  Person? _selectedPerson;

  ProfileViewModel(this.repository);

  Person getPerson(int id) {
    _selectedPerson = repository.getById(id);
    return _selectedPerson!;
  }

  Person? get selectedVariant => _selectedPerson;
}
