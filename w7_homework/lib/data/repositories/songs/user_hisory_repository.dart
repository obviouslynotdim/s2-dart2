abstract class UserHistoryRepository {
  List<String> fetchRecentSongIds();
}

class UserHistoryRepositoryMock implements UserHistoryRepository {
  @override
  List<String> fetchRecentSongIds() {
    // existing mockID in SongRepositoryMock
    return ['101', '102']; 
  }
}