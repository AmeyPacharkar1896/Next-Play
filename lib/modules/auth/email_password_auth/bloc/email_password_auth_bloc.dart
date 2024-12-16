import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/model/user_model.dart';
import 'package:next_play/modules/auth/service/auth_firebase_service.dart';
import 'package:next_play/modules/auth/service/auth_firestore_service.dart';
import 'package:next_play/shared/show_snackbar.dart';

part 'email_password_auth_state.dart';
part 'email_password_auth_event.dart';

class EmailPasswordAuthBloc
    extends Bloc<EmailPasswordAuthEvent, EmailPasswordAuthState> {
  EmailPasswordAuthBloc()
      : super(EmailPasswordAuthState(
          isLoading: false,
          isAuthenticated: false,
        )) {
    on<EmailPasswordAuthEventInitialize>(_onEmailPasswordAuthEventInitialize);
    on<EmailPasswordAuthEventCreateAccount>(
        _onEmailPasswordAuthEventCreateAccount);
    on<EmailPasswordAuthEventLogin>(_onEmailPasswordAuthEventLogin);
    on<EmailPasswordAuthEventLogOut>(_onEmailPasswordAuthEventLogOut);
    on<_EmailPasswordAuthEventCreateUser>(_on_EmailPasswordAuthEventCreateUser);
  }

  final _authService = AuthFirebaseService();
  final _firestoreService = AuthFirestoreService();

  FutureOr<void> _onEmailPasswordAuthEventInitialize(
    EmailPasswordAuthEventInitialize event,
    Emitter<EmailPasswordAuthState> emit,
  ) {
    final response = _authService.isAuthenticated;
    return emit.forEach(response, onData: (isAuthenticated) {
      return state.copyWith(
        isAuthenticated: isAuthenticated,
        currentUser: _authService.currentUser,
      );
    });
  }

  Future<void> _onEmailPasswordAuthEventCreateAccount(
    EmailPasswordAuthEventCreateAccount event,
    Emitter<EmailPasswordAuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.createAccount(
      email: event.emailAddress,
      password: event.password,
    );
    response.fold(
      (L) {
        showSnackBar(L);
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: false,
        ));
      },
      (R) {
        final name = event.name;
        add(
          _EmailPasswordAuthEventCreateUser(
            userModel: UserModel(
              id: R.user?.uid ?? '',
              email: R.user?.email,
              name: name,
              // userType: UserTypeEnum.studentUser,
            ),
          ),
        );
        showSnackBar('Account created!');
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: true,
            currentUser: _authService.currentUser,
          ),
        );
      },
    );
  }

  Future<void> _onEmailPasswordAuthEventLogin(
    EmailPasswordAuthEventLogin event,
    Emitter<EmailPasswordAuthState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final response = await _authService.logIn(
      email: event.emailAddress,
      password: event.password,
    );
    response.fold(
      (L) {
        showSnackBar(L);
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: false,
        ));
      },
      (R) {
        showSnackBar('LogIn Successfully');
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: true,
        ));
      },
    );
  }

  Future<void> _onEmailPasswordAuthEventLogOut(
    EmailPasswordAuthEventLogOut event,
    Emitter<EmailPasswordAuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authService.logOut();
    response.fold(
      (L) {
        showSnackBar(L);
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

  Future<void> _on_EmailPasswordAuthEventCreateUser(
    _EmailPasswordAuthEventCreateUser event,
    Emitter<EmailPasswordAuthState> emit,
  ) async {
    final response = await _firestoreService.createUser(
      userModel: event.userModel,
    );
    response.fold(
      (L) {
        log(L);
        showSnackBar(L);
      },
      (R) {},
    );
  }
}
