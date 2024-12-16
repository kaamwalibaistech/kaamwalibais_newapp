import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthBlocInitial()) {
    on<AuthenticationEvent>(_authentication);
  }

  Future<void> _authentication(
      AuthenticationEvent event, Emitter<AuthBlocState> emit) async {}
}
