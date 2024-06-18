import 'package:CoinKeep/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:CoinKeep/presentation/pages/auth/components/TextFieldComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Icon iconPassword = const Icon(Icons.remove_red_eye_rounded);
  bool signInRequired = false;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFieldComponent(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
              errorMsg: _errorMsg,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFieldComponent(
              controller: passwordController,
              hintText: 'Password',
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(Icons.lock),
              errorMsg: _errorMsg,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid password';
                }
                return null;
              },
              suffixIcon: IconButton(
                  icon: iconPassword,
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if (obscurePassword) {
                        iconPassword = const Icon(Icons.remove_red_eye_rounded);
                      } else {
                        iconPassword =
                            const Icon(Icons.remove_red_eye_outlined);
                      }
                    });
                  }),
            ),
          ),
          const SizedBox(height: 20),
          !signInRequired
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(
                              SignInRequired(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                      }
                    },
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10.0),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
