import 'package:flutter/material.dart';

enum CardType { red, green, yellow, blue }

class ColorService extends ChangeNotifier {
  
  final Map<CardType, int> _tapCounts = {
    CardType.red: 0,
    CardType.green: 0,
    CardType.yellow: 0,
    CardType.blue: 0,
  };

  Map<CardType, int> get tapCounts => _tapCounts;

  void increment(CardType type) {
    _tapCounts[type] = (_tapCounts[type] ?? 0) + 1;
    notifyListeners();
  }
}

ColorService colorService = ColorService();
