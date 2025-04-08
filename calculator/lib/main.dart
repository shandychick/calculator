import 'package:flutter/material.dart';
import 'calculator_screen.dart'; // Impor layar kalkulator

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 1;

  static List<Widget> getWidgetOptions() => <Widget>[
  const HistoryScreen(),
  const CalculatorScreen(),
  const ProfileScreen(), // Tambahkan ini
];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 400,
          minHeight: 500,
          maxHeight: 700,
        ),
        child: Scaffold(
          appBar: AppBar(title: const Text('Calculator')),
          body: getWidgetOptions()[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.event_repeat_sharp), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined), label: 'Calculator'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: history.map((entry) => ListTile(title: Text(entry))).toList(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50, // Ukuran foto profil
            backgroundImage: AssetImage('lib/assets/icons/foto_profil.png'), // Ganti dengan path gambar
          ),
          const SizedBox(height: 20),
          const Text(
            'Anonymous',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
