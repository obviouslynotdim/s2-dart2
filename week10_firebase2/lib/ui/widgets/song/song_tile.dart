import 'package:flutter/material.dart';
import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: ClipOval(
            child: Image.network(
              song.imageUrl.toString(),
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(song.title),
          subtitle: Text('${song.duration.inMinutes} mins'),
          trailing: Text(
            isPlaying ? 'Playing' : '',
            style: const TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
