import 'package:flutter/material.dart';
import 'package:taskmanagementapp/views/starred_page.dart';
import 'package:taskmanagementapp/views/trash_page.dart';
import 'add_task.dart';
import 'home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    AddTask(),
    StarredPage(), // Create this screen
    TrashPage(), // Create this screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: GNav(
        style: GnavStyle.oldSchool,
        activeColor: Colors.red,
        tabBackgroundColor: Colors.black12,
        backgroundColor: Colors.amberAccent,
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabMargin: EdgeInsetsGeometry.all(8),
        curve: Curves.bounceIn,
        padding: EdgeInsetsGeometry.all(10),
        tabBorderRadius: 25,
        tabs: const [
          GButton(icon: Icons.home, text: "Home"),
          GButton(icon: Icons.add, text: "Add task"),
          GButton(icon: Icons.star, text: "Starred"),
          GButton(icon: Icons.delete, text: "Trash"),
        ],
      ),
    );
  }
}
