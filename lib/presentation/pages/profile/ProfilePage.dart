import 'package:CoinKeep/logic/blocs/auth_google_bloc/auth_google_bloc.dart';
import 'package:CoinKeep/presentation/pages/profile/profileConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_abstract_avatar/random_abstract_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              flex: 8, // 4 частини з 5 (80%)
              child: BlocBuilder<AuthGoogleBloc, AuthGoogleState>(
                builder: (context, state) {
                  final user = state.user;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _getUserAvatar(user),
                      _getUserInfo(user, textProfileStyle)
                    ],
                  );
                },
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
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    context
                        .read<AuthGoogleBloc>()
                        .add(const AppLogoutRequested());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log out',
                        style: textProfileStyle,
                      ),
                      SizedBox(width: 10),
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

  Widget _getUserAvatar(user) {
    if (user != null && user.photoURL != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user.photoURL!),
      );
    } else {
      // Випадковий Аватар
      return Avatar(source: 'random');
    }
  }

  Widget _getUserInfo(user, textStyle) {
    if (user != null && user.email != null && user.displayName != null) {
      return Column(
        children: [
          Text(
            user!.email,
            style: textStyle,
          ),
          Text(
            user.displayName!,
            style: textStyle,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            '_',
            style: textStyle,
          ),
          Text(
            '_',
            style: textStyle,
          ),
        ],
      );
    }
  }
}
