import 'package:equatable/equatable.dart';

abstract class SearchCandidateStates extends Equatable {}

class SearchCandidateInitialState extends SearchCandidateStates {
  @override
  List<Object?> get props => [];
}

class SearchCandidateLoadingState extends SearchCandidateStates {
  @override
  List<Object?> get props => [];
}

class SearchCandidateSuccessState extends SearchCandidateStates {
  @override
  List<Object?> get props => [];
}

class SearchCandidateErrorState extends SearchCandidateStates {
  @override
  List<Object?> get props => [];
}
