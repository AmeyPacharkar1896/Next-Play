import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/email_password_auth/bloc/email_password_auth_bloc.dart';
import 'package:next_play/modules/auth/google_auth/bloc/google_auth_bloc.dart';
import 'package:next_play/modules/auth/vew/registration_screen.dart';
import 'package:next_play/screens/home/home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Welcome Back')),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: BlocBuilder<EmailPasswordAuthBloc, EmailPasswordAuthState>(
                builder: (context, state) {
                  return FilledButton(
                      onPressed: () {
                        context.read<EmailPasswordAuthBloc>().add(
                              EmailPasswordAuthEventLogin(
                                emailAddress: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                        state.isAuthenticated
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              )
                            : null;
                      },
                      child: const Text('Log In'));
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No Account Yet?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ));
                  },
                  child: const Text('Register Here'),
                ),
              ],
            ),
            const SizedBox(height: 50),
            BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
              builder: (context, state) {
                return FilledButton.icon(
                  onPressed: () {
                    context.read<GoogleAuthBloc>().add(
                          const GoogleAuthEventSignIn(),
                        );
                        log('Log in with google');
                    state.isAuthenticated
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          )
                        : null;
                  },
                  label: const Text('Google'),
                  icon: const Icon(Icons.g_mobiledata_outlined),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
