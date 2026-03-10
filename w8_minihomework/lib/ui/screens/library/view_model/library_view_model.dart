import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';
enum SongsStatus { loading, success, error } // i handle using enum

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  // List<Song>? _songs;

  // status + songs + errorMessage fields
  SongsStatus status = SongsStatus.loading;
  List<Song> songs = [];
  String? errorMessage;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  // loading first then success or error after the await
  void _init() async {
    status = SongsStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      songs = await songRepository.fetchSongs();
      status = SongsStatus.success;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      status = SongsStatus.error;
    }

    notifyListeners();
  }

  // retry re-runs _init to trigger new fetch
  void retry() => _init();

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
