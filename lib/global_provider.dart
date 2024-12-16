import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/anomanous_auth/bloc/anomanous_auth_bloc.dart';
import 'package:next_play/modules/auth/email_password_auth/bloc/email_password_auth_bloc.dart';
import 'package:next_play/modules/auth/google_auth/bloc/google_auth_bloc.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnomanousAuthBloc>(
          create: (context) => AnomanousAuthBloc(),
        ),
        BlocProvider<EmailPasswordAuthBloc>(
          create: (context) => EmailPasswordAuthBloc(),
        ),
        BlocProvider<GoogleAuthBloc>(
          create: (context) => GoogleAuthBloc(),
        ),
      ],
      child: child,
    );
  }
}
