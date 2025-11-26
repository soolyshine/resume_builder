import '../models/person.dart';

class PersonRepository {
  final List<Person> _info = [
    Person(id: 1, title: 'Name', description: 'Анна Краснобаєва'),
    Person(id: 2, title: 'Email', description: 'anna.krasnobaieva@infiz.khpi.edu.ua'),
    Person(id: 3, title: 'Phone', description: '+380123123123'),
    Person(id: 4, title: 'About me', description: 'Працюю, навчаюся, живу.'),
  ];

  List<Person> getAll() => _info;

  Person getById(int id) => _info.firstWhere((p) => p.id == id);
}
