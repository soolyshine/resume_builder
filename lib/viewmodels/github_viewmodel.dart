import 'package:flutter/material.dart';
import '../repository/github_repository.dart';
import '../models/github_user.dart';

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository repository;

  GitHubViewModel(this.repository);

  GitHubUser? _user;
  bool _isLoading = false;
  String? _error;

  GitHubUser? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUser(String username) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await repository.getUser(username);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
