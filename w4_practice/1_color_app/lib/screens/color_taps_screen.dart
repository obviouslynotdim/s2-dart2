import 'package:flutter/material.dart';
import '../service/color_service.dart';
import '../widgets/color_tap.dart';

class ColorTapsScreen extends StatelessWidget {
  final ColorService colorService;
  const ColorTapsScreen({super.key,  required this.colorService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: ListView(
        children: CardType.values
            .map((type) => ColorTap(
                type: type,
                colorService: colorService,
              ))
            .toList(),
      ),
    );
  }
}
