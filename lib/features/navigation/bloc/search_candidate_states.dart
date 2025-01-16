import 'package:equatable/equatable.dart';

import '../../../models/search_candidate_model.dart';

abstract class SearchCandidateStates extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchCandidateInitialState extends SearchCandidateStates {
  @override
  List<Object> get props => [];
}

class SearchCandidateLoadingState extends SearchCandidateStates {
  @override
  List<Object> get props => [];
}

class SearchCandidateSuccessState extends SearchCandidateStates {
  final List<SearchcandidateData> candidates;
  SearchCandidateSuccessState({required this.candidates});
  @override
  List<Object> get props => [candidates];
}

class SearchCandidateCountLoaded extends SearchCandidateStates {
  final String candidatecount;
  SearchCandidateCountLoaded({required this.candidatecount});
  @override
  List<Object> get props => [candidatecount];
}

class SearchCandidateErrorState extends SearchCandidateStates {
  final String errorMsg;
  SearchCandidateErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
