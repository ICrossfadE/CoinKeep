import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

// constructor
  const BottomNavigationBarExample(
      {Key? key, required this.selectedIndex, required this.onItemTapped, re})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.control_point_duplicate_rounded),
          label: 'Assets',
          backgroundColor: colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.import_export_rounded),
          label: 'Transactions',
          backgroundColor: colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profile',
          backgroundColor: colorScheme.secondary,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: colorScheme.onPrimary,
      onTap: onItemTapped,
    );
  }
}
