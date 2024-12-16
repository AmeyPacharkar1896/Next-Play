import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/model/user_model.dart';
import 'package:next_play/modules/auth/service/auth_firebase_service.dart';
import 'package:next_play/modules/auth/service/auth_firestore_service.dart';
import 'package:next_play/shared/show_snackbar.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc()
      : super(GoogleAuthState(
          isLoading: false,
          isAuthenticated: false,
          currentUser: null,
        )) {
    on<GoogleAuthEventSignIn>(_onGoogleAuthEventSignIn);
    on<GoogleAuthEventSignOut>(_onGoogleAuthEventSignOut);
    on<_onGoogleAuthEventCreateUser>(__onGoogleAuthEventCreateUser);
  }

  final _authService = AuthFirebaseService();
  final _firestoreService = AuthFirestoreService();

  Future<void> _onGoogleAuthEventSignIn(
    GoogleAuthEvent event,
    Emitter<GoogleAuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Show loading indicator

    final response = await _authService.signInWithGoogle();
    response.fold(
      (L) {
        showSnackBar(L); // Show error message
        emit(state.copyWith(isLoading: false, isAuthenticated: false));
      },
      (R) {
        // Successful login
        add(_onGoogleAuthEventCreateUser(
            userModel: UserModel(
          id: R.user?.uid ?? '',
          email: R.user?.email,
          // Add other properties if needed
        )));
        showSnackBar('Account created!');
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          currentUser: _authService.currentUser,
        ));
      },
    );
  }

  Future<void> _onGoogleAuthEventSignOut(
    GoogleAuthEventSignOut event,
    Emitter<GoogleAuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.signInWithGoogle();
    response.fold(
      (L) {
        showSnackBar(L); // Show error message
        emit(state.copyWith(isLoading: false, isAuthenticated: false));
      },
      (R) {
        showSnackBar('LogOut Successfully');
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: false,
        ));
      },
    );
  }

  FutureOr<void> __onGoogleAuthEventCreateUser(
    _onGoogleAuthEventCreateUser event,
    Emitter<GoogleAuthState> emit,
  ) async {
    final response =
        await _firestoreService.createUser(userModel: event.userModel);
    log("$response in Google create user");
  }
}
