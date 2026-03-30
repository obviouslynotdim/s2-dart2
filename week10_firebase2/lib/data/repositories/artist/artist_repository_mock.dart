import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../../model/songs/song.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _artists = [];
  final List<Song> _songs = [];
  final List<Comment> _comments = [];

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    return Future.delayed(Duration(seconds: 4), () {
      throw _artists;
    });
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return Future.delayed(Duration(seconds: 4), () {
      return _artists.firstWhere(
        (artist) => artist.id == id,
        orElse: () => throw Exception("No artist with id $id in the database"),
      );
    });
  }

  @override
  Future<List<Song>> fetchArtistSongs(
    String artistId, {
    bool forceFetch = false,
  }) async {
    return Future.delayed(Duration(milliseconds: 200), () {
      return _songs.where((song) => song.artistId == artistId).toList();
    });
  }

  @override
  Future<List<Comment>> fetchArtistComments(
    String artistId, {
    bool forceFetch = false,
  }) async {
    return Future.delayed(Duration(milliseconds: 200), () {
      return _comments
          .where((comment) => comment.artistId == artistId)
          .toList();
    });
  }

  @override
  Future<void> postArtistComment(String artistId, Comment comment) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      _comments.add(comment);
    });
  }

  // @override
  // void clearCache() {
  //   // TODO: implement clearCache
  //   throw UnimplementedError();
  // }
}
