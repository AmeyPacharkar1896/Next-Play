part of 'google_auth_bloc.dart';

class GoogleAuthState {
  GoogleAuthState({
    required this.isLoading,
    required this.isAuthenticated,
    required this.currentUser,
  });

  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? currentUser;

  GoogleAuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? currentUser,
  }) {
    return GoogleAuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
