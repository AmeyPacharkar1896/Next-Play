import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/anomanous_auth/bloc/anomanous_auth_bloc.dart';
import 'package:next_play/modules/auth/email_password_auth/bloc/email_password_auth_bloc.dart';
import 'package:next_play/modules/auth/google_auth/bloc/google_auth_bloc.dart';
import 'package:next_play/modules/auth/vew/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void initState() {
  //   super.initState();
  //   context.read<AnomanousAuthBloc>().add(const AnomanousAuthEvent());
  //   log("Logged in anonymously");
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
      builder: (context, state1) {
        return BlocBuilder<EmailPasswordAuthBloc, EmailPasswordAuthState>(
          builder: (context, state2) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Page'),
                actions: [
                  (state1.isAuthenticated || state2.isAuthenticated)
                      ? PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Text('Log Out'),
                              onTap: () {
                                state1.isAuthenticated
                                    ? Future.delayed(Duration.zero, () {
                                        context.read<GoogleAuthBloc>().add(
                                              const GoogleAuthEventSignOut(),
                                            );
                                      })
                                    : Future.delayed(Duration.zero, () {
                                        context
                                            .read<EmailPasswordAuthBloc>()
                                            .add(
                                              const EmailPasswordAuthEventLogOut(),
                                            );
                                      });
                              },
                            ),
                          ],
                        )
                      : PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Text('Log In'),
                              onTap: () {
                                // Delay to allow the menu to close before navigating
                                Future.delayed(Duration.zero, () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LogInScreen(),
                                    ),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
