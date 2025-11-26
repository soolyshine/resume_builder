class ProfileVariant {
  final String id;
  final String title;      // Напр. "Flutter Developer", "Project Manager"
  final String summary;    // Короткий опис
  final String skills;     // Основні навички
  final String experience; // Досвід роботи / навчання

  ProfileVariant({
    required this.id,
    required this.title,
    required this.summary,
    required this.skills,
    required this.experience,
  });
}
