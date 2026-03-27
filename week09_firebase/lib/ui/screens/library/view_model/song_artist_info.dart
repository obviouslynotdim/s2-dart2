import '../../../../model/artists/artist.dart';
import '../../../../model/songs/song.dart';

class SongArtistInfo {
  final Song song;
  final Artist? artist;

  const SongArtistInfo({required this.song, required this.artist});
}
