import 'package:CoinKeep/logic/blocs/auth_google_bloc/auth_google_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext settingsContext) {
    final fullWidth = MediaQuery.of(settingsContext).size.width;
    const textStyle = TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontFamily: 'PlusJakartaSans');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Expanded(
              flex: 8, // 4 частини з 5 (80%)
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/google.png'),
                    width: 50,
                    height: 50,
                  ),
                  Text('Profile'),
                ],
              ),
            ),
            Expanded(
              flex: 1, // 1 частина з 5 (20%)
              child: Container(
                width: fullWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () {
                    settingsContext
                        .read<AuthGoogleBloc>()
                        .add(const AppLogoutRequested());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log out',
                        style: textStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.login),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
