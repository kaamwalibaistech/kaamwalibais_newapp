import 'package:equatable/equatable.dart';

abstract class SearchCandidateEvent extends Equatable {}

class SearchCandidateFilterEvent extends SearchCandidateEvent {
  @override
  List<Object?> get props => [];
}

class SearchCandidateSortEvent extends SearchCandidateEvent {
  @override
  List<Object?> get props => [];
}
