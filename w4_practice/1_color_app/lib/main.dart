import 'package:flutter/material.dart';
import 'service/color_service.dart';
import 'screens/color_taps_screen.dart';
import 'screens/statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // late final ColorService _colorService;

  // @override
  // void initState() {
  //   super.initState();
  //   _colorService = ColorService();
  // }

  // @override
  // void dispose() {
  //   _colorService.dispose(); 
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, _) {
        return Scaffold(
          body: _currentIndex == 0
              ? ColorTapsScreen(colorService: colorService)
              : StatisticsScreen(colorService: colorService),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.tap_and_play),
                label: 'Taps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Statistics',
              ),
            ],
          ),
        );
      },
    );
  }
}
