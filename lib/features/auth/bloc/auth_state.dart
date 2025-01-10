import 'package:equatable/equatable.dart';

import '../../../models/employer_register_model.dart';

enum USERFAILED { unregister, networkerror }

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

class AuthLoadingState extends AuthBlocState {
  @override
  List<Object> get props => [];
}

class AuthLoadedState extends AuthBlocState {
  final EmployerRegisterModel userData;
  AuthLoadedState({required this.userData});
  @override
  List<Object> get props => [userData];
}

// class AuthCandidateLoadedState extends AuthBlocState {
//   final EmployerRegisterModel userData;
//   AuthCandidateLoadedState({required this.userData});
//   @override
//   List<Object> get props => [userData];
// }

class AuthLoadFailedState extends AuthBlocState {
  final USERFAILED userfailed;
  AuthLoadFailedState({required this.userfailed});
  @override
  List<Object> get props => [userfailed];
}

// class CandidateAuthLoadedState extends AuthBlocState {
//   final CandidateData userData;
//   CandidateAuthLoadedState({required this.userData});
//   @override
//   List<Object> get props => [userData];
// }
