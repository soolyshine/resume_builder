import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_user.dart';

class GitHubService {
  final http.Client _client;

  GitHubService() : _client = http.Client();
  GitHubService.withClient(this._client); // 👈 Додаємо це

  Future<GitHubUser> fetchUser(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username');
    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GitHubUser.fromJson(data);
    } else {
      throw Exception('Не вдалося отримати дані користувача');
    }
  }
}
