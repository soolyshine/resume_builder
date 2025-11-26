import 'package:flutter/material.dart';
import '../repository/person_repository.dart';
import '../models/person.dart';

class HomeViewModel extends ChangeNotifier {
  final PersonRepository repository;

  HomeViewModel(this.repository);

  List<Person> get persons => repository.getAll();
}
