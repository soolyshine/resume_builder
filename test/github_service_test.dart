import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:lab9/services/github_service.dart';
import 'package:lab9/models/github_user.dart';

void main() {
  group('GitHubService', () {
    test('повертає користувача при статусі 200', () async {
      // створюємо mock HTTP клієнт
      final client = MockClient((request) async {
        final mockJson = jsonEncode({
          'login': 'soolyshine',
          'avatar_url': 'https://example.com/avatar.png',
          'bio': 'Flutter developer',
          'public_repos': 10,
          'followers': 5,
          'following': 3,
        });

        return http.Response(mockJson, 200);
      });

      // створюємо сервіс, який використовує наш mock клієнт
      final service = GitHubService.withClient(client);

      // викликаємо метод
      final GitHubUser user = await service.fetchUser('soolyshine');

      // перевіряємо результат
      expect(user.login, 'soolyshine');
      expect(user.publicRepos, 10);
      expect(user.followers, 5);
      expect(user.following, 3);
    });

    test('викидає помилку при статусі != 200', () async {
      final client = MockClient((request) async {
        return http.Response('Not found', 404);
      });

      final service = GitHubService.withClient(client);

      expect(
        () async => await service.fetchUser('unknown_user'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
