import '../models/github_user.dart';
import '../services/github_service.dart';

class GitHubRepository {
  final GitHubService service;

  GitHubRepository(this.service);

  Future<GitHubUser> getUser(String username) async {
    return await service.fetchUser(username);
  }
}
