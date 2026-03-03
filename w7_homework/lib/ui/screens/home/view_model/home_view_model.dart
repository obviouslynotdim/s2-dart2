import 'package:flutter/widgets.dart';
import '../../../../../data/repositories/songs/song_repository.dart';
import '../../../../../model/songs/song.dart';
import '../../../../data/repositories/songs/user_history_repository.dart';
import '../../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final UserHistoryRepository _historyRepository;
  final PlayerState _playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({
    required SongRepository songRepository,
    required UserHistoryRepository historyRepository,
    required PlayerState playerState,
  })  : _songRepository = songRepository,
        _historyRepository = historyRepository,
        _playerState = playerState {
    _playerState.addListener(notifyListeners);
    init();
  }

  void init(){
    // fetch recentid from repo
    final recentIds = _historyRepository.fetchRecentSongIds();
    _recentSongs = recentIds
        .map((id) => _songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();

    _recommendedSongs = _songRepository.fetchSongs();

    notifyListeners();
  }

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;
  
  bool isPlaying(Song song) => _playerState.currentSong?.id == song.id;

  void play(Song song) => _playerState.start(song);
  void stop() => _playerState.stop();

  @override
  void dispose() {
    _playerState.removeListener(notifyListeners);
    super.dispose();
  }
}