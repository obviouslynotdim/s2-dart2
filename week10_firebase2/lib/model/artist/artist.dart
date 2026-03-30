class Artist {
  final String id;
  final String name;
  final String genre;
  final Uri imageUrl;
  final String? about;

  Artist({
    required this.id,
    required this.name,
    required this.genre,
    required this.imageUrl,
    this.about,
  });

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, genre: $genre, about: $about)';
  }
}
