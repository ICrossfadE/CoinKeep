// import 'package:CoinKeep/logic/blocs/local_cache_bloc/local_cache_bloc.dart';
import 'package:CoinKeep/presentation/screens/dashboard/BottomNavItems.dart';
import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardScreen> {
  //Індекс вибраного елемента
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBg,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Center(
              child: BottomNavItems.getWidgets().elementAt(_selectedIndex),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          decoration: BoxDecoration(
              color: kDark500,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 0),
                  blurRadius: 30,
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomNavBarItem(context,
                  icon: IconlyLight.home, page: 0, lable: 'Home'),
              _bottomNavBarItem(context,
                  icon: IconlyLight.wallet, page: 1, lable: 'Wallets'),
              _bottomNavBarItem(context,
                  icon: IconlyLight.swap, page: 2, lable: 'Transactions'),
              _bottomNavBarItem(context,
                  icon: IconlyLight.document, page: 3, lable: 'Assets'),
              _bottomNavBarItem(context,
                  icon: IconlyLight.profile, page: 4, lable: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavBarItem(BuildContext context,
      {required IconData icon, required page, required String lable}) {
    return ZoomTapAnimation(
      onTap: () {
        //Звуковий відгук
        Feedback.forTap(context);
        setState(() {
          _selectedIndex = page;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: page == _selectedIndex ? kConfirmColor : Colors.white,
            ),
            Text(
              lable,
              style: page == _selectedIndex ? kNavTextActive : kNavTextUnective,
            ),
          ],
        ),
      ),
    );
  }
}
