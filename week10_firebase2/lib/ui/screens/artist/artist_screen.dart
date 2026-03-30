import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/artist/artist_repository.dart';
import '../../../model/artist/artist.dart';
import '../../states/settings_state.dart';
import '../../states/player_state.dart';
import '../../widgets/song/song_tile.dart';
import 'view_model/artist_view_model.dart';
import 'widgets/comment_tile.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistViewModel(
        artistRepository: context.read<ArtistRepository>(),
        artist: artist,
      ),
      child: _ArtistScreenView(artist: artist),
    );
  }
}

class _ArtistScreenView extends StatefulWidget {
  const _ArtistScreenView({required this.artist});

  final Artist artist;

  @override
  State<_ArtistScreenView> createState() => _ArtistScreenViewState();
}

class _ArtistScreenViewState extends State<_ArtistScreenView> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final String message = _commentController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a comment first.')),
      );
      return;
    }

    final ArtistViewModel vm = context.read<ArtistViewModel>();
    await vm.addComment(message);

    if (!mounted) {
      return;
    }

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ArtistViewModel vm = context.watch<ArtistViewModel>();
    final PlayerState playerState = context.watch<PlayerState>();
    final AppSettingsState settingsState = context.watch<AppSettingsState>();
    final Color themeColor = settingsState.theme.color;
    final Color backgroundColor = settingsState.theme.backgroundColor;

    Widget body;
    if (vm.isLoading) {
      body = Center(child: CircularProgressIndicator(color: themeColor));
    } else if (vm.error != null) {
      body = Center(
        child: Text(
          'error = ${vm.error}',
          style: TextStyle(color: Colors.red.shade700),
        ),
      );
    } else {
      body = RefreshIndicator(
        color: themeColor,
        onRefresh: () => vm.fetchData(forceFetch: true),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              widget.artist.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(widget.artist.genre),
            const SizedBox(height: 20),
            Text('Songs', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (vm.songs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('No songs yet for this artist.'),
              )
            else
              ...vm.songs.map(
                (song) => SongTile(
                  song: song,
                  isPlaying: playerState.currentSong == song,
                  onTap: () {
                    playerState.start(song);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text('Comments', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (vm.comments.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('No comments yet. Be the first to comment.'),
              )
            else
              ...vm.comments.map((comment) => CommentTile(comment: comment)),
            const SizedBox(height: 80),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.artist.name),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
      ),
      body: body,
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment',
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor, width: 2),
                    ),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _submitComment(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: _submitComment,
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
