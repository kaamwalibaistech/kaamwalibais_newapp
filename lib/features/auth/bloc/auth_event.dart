import 'package:equatable/equatable.dart';

abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationEvent extends AuthBlocEvent {
  AuthenticationEvent();

  @override
  List<Object> get props => [];
}
