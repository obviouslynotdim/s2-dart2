import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week10/config/firebase_config.dart';

import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../../model/songs/song.dart';
import '../../dtos/artist_dto.dart';
import '../../dtos/comment_dto.dart';
import '../../dtos/song_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = FirebaseConfig.baseUrl.replace(path: '/artists.json');
  final Uri songsUri = FirebaseConfig.baseUrl.replace(path: '/songs.json');
  final Uri commentsUri = FirebaseConfig.baseUrl.replace(
    path: '/comments.json',
  );

  List<Artist>? _cachedArtists;
  final Map<String, List<Song>> _cachedSongsByArtist = {};
  final Map<String, List<Comment>> _cachedCommentsByArtist = {};

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    if (_cachedArtists != null && !forceFetch) {
      return List<Artist>.from(_cachedArtists!);
    }

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final dynamic decoded = json.decode(response.body);
      if (decoded == null) {
        _cachedArtists = [];
        return [];
      }

      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = decoded;

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      _cachedArtists = result;
      return List<Artist>.from(_cachedArtists!);
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    if (_cachedArtists == null) {
      await fetchArtists();
    }

    try {
      return _cachedArtists!.firstWhere((artist) => artist.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Song>> fetchArtistSongs(
    String artistId, {
    bool forceFetch = false,
  }) async {
    if (_cachedSongsByArtist[artistId] != null && !forceFetch) {
      return List<Song>.from(_cachedSongsByArtist[artistId]!);
    }

    final http.Response response = await http.get(songsUri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch artist songs');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      _cachedSongsByArtist[artistId] = [];
      return [];
    }

    final Map<String, dynamic> songsJson = decoded;
    final List<Song> songs = [];
    for (final entry in songsJson.entries) {
      final Song song = SongDto.fromJson(entry.key, entry.value);
      if (song.artistId == artistId) {
        songs.add(song);
      }
    }

    _cachedSongsByArtist[artistId] = songs;
    return List<Song>.from(songs);
  }

  @override
  Future<List<Comment>> fetchArtistComments(
    String artistId, {
    bool forceFetch = false,
  }) async {
    if (_cachedCommentsByArtist[artistId] != null && !forceFetch) {
      return List<Comment>.from(_cachedCommentsByArtist[artistId]!);
    }

    final http.Response response = await http.get(commentsUri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch artist comments');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      _cachedCommentsByArtist[artistId] = [];
      return [];
    }

    final Map<String, dynamic> commentsJson = decoded;
    final List<Comment> comments = [];
    for (final entry in commentsJson.entries) {
      final Comment comment = CommentDto.fromJson(entry.key, entry.value);
      if (comment.artistId == artistId) {
        comments.add(comment);
      }
    }

    comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _cachedCommentsByArtist[artistId] = comments;
    return List<Comment>.from(comments);
  }

  @override
  Future<void> postArtistComment(String artistId, Comment comment) async {
    final http.Response response = await http.post(
      commentsUri,
      body: json.encode(CommentDto().toJson(comment)),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post comment');
    }

    final List<Comment>? cachedComments = _cachedCommentsByArtist[artistId];
    if (cachedComments != null) {
      _cachedCommentsByArtist[artistId] = [comment, ...cachedComments];
    }
  }
}
