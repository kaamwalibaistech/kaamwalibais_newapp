import 'package:equatable/equatable.dart';

import '../../../Client/homepage_api.dart';

abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationEvent extends AuthBlocEvent {
  final String phoneNumber;
  final String password;
  final USER userType;
  AuthenticationEvent(
      {required this.phoneNumber,
      required this.password,
      required this.userType});
  @override
  List<Object> get props => [phoneNumber, password];
}

// class AuthenticationEventCandidate extends AuthBlocEvent {
//   final String phoneNumber;
//   final String password;
//   final USER userType;
//   AuthenticationEventCandidate(
//       {required this.phoneNumber,
//       required this.password,
//       required this.userType});
//   @override
//   List<Object> get props => [phoneNumber, password];
// }
