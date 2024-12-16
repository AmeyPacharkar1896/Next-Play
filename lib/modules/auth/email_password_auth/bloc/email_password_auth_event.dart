part of 'email_password_auth_bloc.dart';

abstract class EmailPasswordAuthEvent {
  const EmailPasswordAuthEvent();
}

class EmailPasswordAuthEventLogin extends EmailPasswordAuthEvent {
  EmailPasswordAuthEventLogin({
    required this.emailAddress,
    required this.password,
  });

  final String emailAddress;
  final String password;
}

class EmailPasswordAuthEventCreateAccount extends EmailPasswordAuthEvent {
  EmailPasswordAuthEventCreateAccount({
    required this.name,
    required this.emailAddress,
    required this.password,
  });

  final String name;
  final String emailAddress;
  final String password;
}

class EmailPasswordAuthEventInitialize extends EmailPasswordAuthEvent {
  const EmailPasswordAuthEventInitialize();
}

class EmailPasswordAuthEventLogOut extends EmailPasswordAuthEvent {
  const EmailPasswordAuthEventLogOut();
}

class _EmailPasswordAuthEventCreateUser extends EmailPasswordAuthEvent {
  const _EmailPasswordAuthEventCreateUser({
    required this.userModel,
  });

  final UserModel userModel;
}
