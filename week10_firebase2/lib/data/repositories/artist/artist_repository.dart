import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../../model/songs/song.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists({bool forceFetch = false});

  Future<Artist?> fetchArtistById(String id);

  Future<List<Song>> fetchArtistSongs(
    String artistId, {
    bool forceFetch = false,
  });

  Future<List<Comment>> fetchArtistComments(
    String artistId, {
    bool forceFetch = false,
  });

  Future<void> postArtistComment(String artistId, Comment comment);
}
