import 'dart:ui';

import 'package:CoinKeep/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:CoinKeep/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:CoinKeep/logic/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:CoinKeep/presentation/pages/auth/SignInPage.dart';
import 'package:CoinKeep/presentation/pages/auth/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage(BuildContext authContext, {super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext authContext) {
    final colorScheme = Theme.of(authContext).colorScheme;
    final fullScreenHeight = MediaQuery.of(authContext).size.height;

    return Scaffold(
        backgroundColor: colorScheme.onSurface,
        body: SingleChildScrollView(
          child: SizedBox(
            height: fullScreenHeight,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(15, -1.5),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(6, 206, 1, 0.8),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-10, -0.8),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(6, 206, 1, 0.5),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-8, -1.8),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(246, 250, 112, 1),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-25, -1.4),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(246, 250, 112, 1),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-35, -1.8),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(58, 190, 249, 1),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 80.0,
                    sigmaY: 80.0,
                  ),
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: fullScreenHeight / 1.6,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                          child: TabBar.secondary(
                            controller: tabController,
                            unselectedLabelColor:
                                colorScheme.surface.withOpacity(0.5),
                            labelColor: colorScheme.surface,
                            tabs: const <Widget>[
                              Tab(
                                child: Text(
                                  'Sing In',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Sing Up',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              BlocProvider<SignInBloc>(
                                create: (context) => SignInBloc(
                                    userRepository: context
                                        .read<AuthBloc>()
                                        .userRepository),
                                child: const SignInPage(),
                              ),
                              BlocProvider<SignUpBloc>(
                                create: (context) => SignUpBloc(
                                    userRepository: context
                                        .read<AuthBloc>()
                                        .userRepository),
                                child: const SignUpPage(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
