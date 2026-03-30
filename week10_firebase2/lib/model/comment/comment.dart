class Comment {
  final String id;
  final String artistId;
  final String message;
  final String author;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.artistId,
    required this.message,
    required this.author,
    required this.createdAt,
  });
}
