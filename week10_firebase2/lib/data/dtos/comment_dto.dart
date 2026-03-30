import '../../model/comment/comment.dart';

class CommentDto {
  static const String artistIdKey = 'artistId';
  static const String messageKey = 'message';
  static const String authorKey = 'author';
  static const String createdAtKey = 'createdAt';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    final int createdAtMs = json[createdAtKey] is int ? json[createdAtKey] : 0;

    return Comment(
      id: id,
      artistId: json[artistIdKey] ?? '',
      message: json[messageKey] ?? '',
      author: json[authorKey] ?? 'Anonymous',
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAtMs),
    );
  }

  Map<String, dynamic> toJson(Comment comment) {
    return {
      artistIdKey: comment.artistId,
      messageKey: comment.message,
      authorKey: comment.author,
      createdAtKey: comment.createdAt.millisecondsSinceEpoch,
    };
  }
}
