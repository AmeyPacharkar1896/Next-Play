part of 'anomanous_auth_bloc.dart';

class AnomanousAuthState {
  AnomanousAuthState({
    this.message,
  });

  final String? message;
  final bool isAuthenticated = false;

  AnomanousAuthState copyWith({
    String? message,
  }) {
    return AnomanousAuthState(
      message: this.message ?? message,
    );
  }
}
