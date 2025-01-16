import 'package:equatable/equatable.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';

abstract class SearchCandidateEvent extends Equatable {}

class SearchCandidateLoadDataEvent extends SearchCandidateEvent {
  SearchCandidateLoadDataEvent({
    required this.candidateRequest,
  });
  final CandidateRequest candidateRequest;
  @override
  List<Object?> get props => [];
}

class SearchCandidateFilterEvent extends SearchCandidateEvent {
  @override
  List<Object?> get props => [];
}

class SearchCandidateSortEvent extends SearchCandidateEvent {
  @override
  List<Object?> get props => [];
}
