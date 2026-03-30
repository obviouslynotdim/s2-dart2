import 'package:flutter/material.dart';

import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/comment/comment.dart';
import '../../../../model/songs/song.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final Artist artist;

  List<Song> songs = [];
  List<Comment> comments = [];

  bool isLoading = false;
  Object? error;

  ArtistViewModel({required this.artistRepository, required this.artist}) {
    fetchData();
  }

  Future<void> fetchData({bool forceFetch = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final List<Song> fetchedSongs = await artistRepository.fetchArtistSongs(
        artist.id,
        forceFetch: forceFetch,
      );
      final List<Comment> fetchedComments = await artistRepository
          .fetchArtistComments(artist.id, forceFetch: forceFetch);

      songs = fetchedSongs;
      comments = fetchedComments;
    } catch (e) {
      error = e;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> addComment(String message) async {
    final String trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty) {
      return;
    }

    final Comment newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      artistId: artist.id,
      message: trimmedMessage,
      author: 'You',
      createdAt: DateTime.now(),
    );

    await artistRepository.postArtistComment(artist.id, newComment);

    comments = [newComment, ...comments];
    notifyListeners();
  }
}
