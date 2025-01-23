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
  final bool isRefresh;
  AuthenticationEvent(
      {required this.phoneNumber,
      required this.password,
      required this.userType,
      this.isRefresh = false});
  @override
  List<Object> get props => [phoneNumber, password];
}

class GetUserProfile extends AuthBlocEvent {
  final String userId;
  final String flag;

  GetUserProfile({required this.userId, required this.flag});

  @override
  List<Object> get props => [userId];
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
