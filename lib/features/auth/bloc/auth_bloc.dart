import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';

import '../../../core/local_storage.dart';
import '../../../models/employer_register_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(AuthBlocInitial()) {
    on<AuthenticationEvent>(_authentication);
    on<AuthenticationEventCandidate>(_candidateAuthentication);
  }
  AuthRepository authRepository = AuthRepository();

  Future<void> _authentication(
      AuthenticationEvent event, Emitter<AuthBlocState> emit) async {
    try {
      emit(AuthLoadingState());
      EmployerRegisterModel? localUserProfileData =
          LocalStoragePref.instance?.getUserProfile();

      if (localUserProfileData != null) {
        emit(AuthLoadedState(userData: localUserProfileData));
      } else {
        EmployerRegisterModel? employerDetails = await authRepository.userLogin(
            event.phoneNumber, event.password, event.userType);
        if (employerDetails != null && employerDetails.status == '200') {
          // store locally
          LocalStoragePref.instance
              ?.storeUserProfile(jsonEncode(employerDetails.toJson()));
          emit(AuthLoadedState(userData: employerDetails));
        } else {
          emit(AuthLoadFailedState(userfailed: USERFAILED.unregister));
        }
      }
    } catch (e) {
      emit(AuthLoadFailedState(userfailed: USERFAILED.networkerror));
      print(e.toString());
    }
  }

  Future<void> _candidateAuthentication(
      AuthenticationEventCandidate event, Emitter<AuthBlocState> emit) async {
    try {
      emit(AuthLoadingState());
      EmployerRegisterModel? localUserProfileData =
          LocalStoragePref.instance?.getCandidateProfile();

      if (localUserProfileData != null) {
        emit(AuthCandidateLoadedState(userData: localUserProfileData));
      } else {
        EmployerRegisterModel? candidateDetails =
            await authRepository.candidateUserLogin(
                event.phoneNumber, event.password, event.userType);
        if (candidateDetails != null) {
          // store locally
          LocalStoragePref.instance
              ?.storeCandidateProfile(jsonEncode(candidateDetails.toJson()));
          emit(AuthCandidateLoadedState(userData: candidateDetails));
        } else {
          emit(AuthLoadFailedState(userfailed: USERFAILED.unregister));
        }
      }
    } catch (e) {
      emit(AuthLoadFailedState(userfailed: USERFAILED.networkerror));
      print(e.toString());
    }
  }
}
