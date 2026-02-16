// import 'package:flutter/material.dart';
// import '../service/color_service.dart';
// import 'color_taps_screen.dart';
// import 'statistics_screen.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: colorService,
//       builder: (context, _) {
//         return Scaffold(
//           body: _currentIndex == 0
//               ? ColorTapsScreen()
//               : StatisticsScreen(),
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.tap_and_play),
//                 label: 'Taps',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.bar_chart),
//                 label: 'Statistics',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
