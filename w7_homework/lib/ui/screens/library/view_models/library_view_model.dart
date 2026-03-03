import 'package:flutter/widgets.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _repository;
  final PlayerState _playerState;
  
  List<Song> _songs = [];

  LibraryViewModel({
    required SongRepository repository,
    required PlayerState playerState,
  })  : _repository = repository,
        _playerState = playerState {
    // listen to player  changes
    _playerState.addListener(notifyListeners);
    init();
  }

  // init to fetch songs from the repository
  Future<void> init() async {
    _songs = _repository.fetchSongs();
    notifyListeners();
  }

  List<Song> get songs => _songs;
  
  bool isPlaying(Song song) => _playerState.currentSong?.id == song.id;

  void play(Song song) => _playerState.start(song);
  void stop() => _playerState.stop();

  @override
  void dispose() {
    _playerState.removeListener(notifyListeners);
    super.dispose();
  }
}