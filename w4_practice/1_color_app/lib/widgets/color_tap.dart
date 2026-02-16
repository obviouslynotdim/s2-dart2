import 'package:flutter/material.dart';
import '../service/color_service.dart';

class ColorTap extends StatelessWidget {
  final CardType type;
  final ColorService colorService;

  const ColorTap({super.key, required this.type, required this.colorService,});

  Color get backgroundColor {
  switch (type) {
    case CardType.red:
      return Colors.red;
    case CardType.blue:
      return Colors.blue;
    case CardType.green:
      return Colors.green;
    case CardType.yellow:
      return Colors.yellow;
  }
}

  @override
  Widget build(BuildContext context) {
    final tapCount = colorService.tapCounts[type] ?? 0;

    return GestureDetector(
      onTap: () => colorService.increment(type),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
