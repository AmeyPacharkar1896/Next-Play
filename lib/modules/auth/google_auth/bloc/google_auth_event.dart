part of 'google_auth_bloc.dart';

abstract class GoogleAuthEvent {
  const GoogleAuthEvent();
}

class GoogleAuthEventSignIn extends GoogleAuthEvent {
  const GoogleAuthEventSignIn();
}

class GoogleAuthEventSignOut extends GoogleAuthEvent {
  const GoogleAuthEventSignOut();
}

class _onGoogleAuthEventCreateUser extends GoogleAuthEvent {
  _onGoogleAuthEventCreateUser({
    required this.userModel,
  });

  final UserModel userModel;
}
