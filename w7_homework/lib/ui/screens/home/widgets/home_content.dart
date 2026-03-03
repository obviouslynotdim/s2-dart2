import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../states/settings_state.dart';
import '../../../theme/theme.dart';
import '../../library/widgets/library_content.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final settingsState = context.watch<AppSettingsState>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(child: Text("Home", style: AppTextStyles.heading)),
          const SizedBox(height: 16),

          const Text("Your recent songs", style: TextStyle(fontSize: 18, color: Colors.grey)),
          ...viewModel.recentSongs.map(
            (song) => SongTile(
              song: song,
              isPlaying: viewModel.isPlaying(song),
              onTap: () => viewModel.play(song),
              onStop: viewModel.stop,
            ),
          ),

          const SizedBox(height: 16),
          const Text("You might also like", style: TextStyle(fontSize: 18, color: Colors.grey)),
          ...viewModel.recommendedSongs.map(
            (song) => SongTile(
              song: song,
              isPlaying: viewModel.isPlaying(song),
              onTap: () => viewModel.play(song),
              onStop: viewModel.stop,
            ),
          ),
        ],
      ),
    );
  }
}
