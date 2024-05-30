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
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.control_point_duplicate_rounded),
          label: 'Assets',
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.import_export_rounded),
          label: 'Transactions',
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Profile',
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Color.fromARGB(255, 65, 176, 110),
      onTap: onItemTapped,
    );
  }
}
