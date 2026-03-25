import 'package:flutter/material.dart';
import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    this.artistName,
    this.artistGenre,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final String? artistName;
  final String? artistGenre;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final String? artistInformation = artistName == null
        ? null
        : '$artistName - ${artistGenre ?? 'Unknown'}';

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: ClipOval(
            child: Image.network(
              '${song.imageUrl}',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(song.title),
          subtitle: Text(
            artistInformation == null
                ? '${song.duration.inMinutes} mins'
                : '${song.duration.inMinutes} mins   $artistInformation',
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
