import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_play/modules/auth/service/auth_firebase_service.dart';

part 'anomanous_auth_state.dart';
part 'anomanous_auth_event.dart';

class AnomanousAuthBloc extends Bloc<AnomanousAuthEvent, AnomanousAuthState> {
  AnomanousAuthBloc() : super(AnomanousAuthState()) {
    on<AnomanousAuthEvent>(_onAnomanousAuthEvent);
  }

  final _authFirebaseService = AuthFirebaseService();

  Future<void> _onAnomanousAuthEvent(
    AnomanousAuthEvent event,
    Emitter<AnomanousAuthState> emit,
  ) async {
    final response = await _authFirebaseService.loginAnomonously();

    response.fold(
      (L) {
        emit(state.copyWith(message: L));
      },
      (R) {
        emit(AnomanousAuthState());
      },
    );
  }
}
