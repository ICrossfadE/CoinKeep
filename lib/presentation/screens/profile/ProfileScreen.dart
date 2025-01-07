import 'dart:ui';

import 'package:CoinKeep/presentation/widgets/WidthButton.dart';

import 'package:CoinKeep/src/constants/colors.dart';
import 'package:CoinKeep/src/constants/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:random_abstract_avatar/random_abstract_avatar.dart';

import 'package:CoinKeep/logic/blocs/auth_google_bloc/auth_google_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -1.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kConfirmColor,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.6),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kCancelColor,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -1.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kConfirmColor,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                            const Text(
                              'Profile',
                              style: kMediumText,
                            ),
                            const SizedBox(height: 80),
                            _getUserAvatar(user),
                            const SizedBox(height: 20),
                            _getUserInfo(user, kSmallText)
                          ],
                        );
                      },
                    ),
                  ),
                  logOutButton(context),
                ],
              ),
            ),
          ],
        ));
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
          Text(user!.email, style: textStyle),
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

  Widget logOutButton(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 1, // 1 частина з 5 (20%)
      child: Container(
        width: fullWidth,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        child: WidthButton(
          buttonColor: kCancelColor.withAlpha(60),
          iconColor: kCancelColor,
          buttonText: 'Log out',
          buttonTextStyle: kCancelButton,
          borderRadius: 10,
          buttonIcon: IconlyLight.logout,
          buttonBorder: const BorderSide(width: 2, color: kCancelColor),
          onPressed: () {
            context.read<AuthGoogleBloc>().add(const AppLogoutRequested());
          },
        ),
      ),
    );
  }
}
