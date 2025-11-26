class GitHubUser {
  final String login;
  final String avatarUrl;
  final String? bio;
  final int publicRepos;
  final int followers;
  final int following;

  GitHubUser({
    required this.login,
    required this.avatarUrl,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      bio: json['bio'] ?? 'No bio',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}
