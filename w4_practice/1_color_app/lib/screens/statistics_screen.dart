import 'package:flutter/material.dart';
import '../service/color_service.dart';

class StatisticsScreen extends StatelessWidget {
  final ColorService colorService;

  const StatisticsScreen({super.key, required this.colorService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: CardType.values.map((type) {
              final count = colorService.tapCounts[type] ?? 0;
              return Text(
                '${type.name} Taps: $count',
                style: const TextStyle(fontSize: 24),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
