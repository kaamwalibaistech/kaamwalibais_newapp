import 'package:equatable/equatable.dart';

abstract class AuthBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthBlocInitial extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthLoginState extends AuthBlocState {
  final bool isLogin;
  AuthLoginState({required this.isLogin});
  @override
  List<Object> get props => [isLogin];
}
