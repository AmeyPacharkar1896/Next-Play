part of 'email_password_auth_bloc.dart';

class EmailPasswordAuthState {
  EmailPasswordAuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.currentUser,
  });

  final bool isLoading;
  final bool isAuthenticated;
  final UserModel? currentUser;
  
  EmailPasswordAuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserModel? currentUser,
  }) {
    return EmailPasswordAuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}