import 'package:CoinKeep/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext settingsContext) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Image(
              image: AssetImage('assets/google.png'),
              width: 50,
              height: 50,
            ),
          ),
          const Text('Profile'),
          IconButton(
            onPressed: () {
              settingsContext.read<SignInBloc>().add(const SignOutRequired());
            },
            icon: const Icon(Icons.login),
          )
        ],
      ),
    ));
  }
}
