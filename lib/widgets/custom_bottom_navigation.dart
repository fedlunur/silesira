import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30, color: Colors.white),
      const Icon(Icons.add, size: 30, color: Colors.white),
      const Icon(Icons.notifications, size: 30, color: Colors.white),
      const Icon(Icons.person, size: 30, color: Colors.white),
    ];

    return CurvedNavigationBar(
      backgroundColor: Colors.transparent, // Matches the body background
      color: const Color(0xFF3F72AF), // Color of the nav bar
      buttonBackgroundColor:
          const Color(0xFF112D4E), // Highlighted button color
      height: 60, // Adjust the height as needed
      index: currentIndex, // Currently selected index
      animationDuration: const Duration(milliseconds: 300), // Smooth transition
      animationCurve: Curves.easeInOut, // Animation type
      items: items,
      onTap: (index) => onTap(index),
    );
  }
}
