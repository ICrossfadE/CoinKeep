import 'package:CoinKeep/presentation/widgets/VerticalSwipeList.dart';
import 'package:CoinKeep/src/theme/dark.dart';
import 'package:flutter/material.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Клавіатура не змінює розмір вмісту
      backgroundColor: kDarkBg,
      body: Column(
        children: [
          GestureDetector(
            child: SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 35),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child:
                                Icon(Icons.add, size: 40, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          child: Text(
                            'Add Wallet',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height - 250,
                ),
                child: const IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [VerticalSwipeList()],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
