import 'package:equatable/equatable.dart';

import '../../../models/candidate_request.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCandidates extends DashboardEvent {
  final CandidateRequest candidateRequest;
  final int pageKey;

  GetCandidates({
    required this.candidateRequest,
    required this.pageKey,
  });
}

class GetDatabyCategory extends DashboardEvent {
  GetDatabyCategory({required this.candidateRequest});
  final CandidateRequest candidateRequest;
  @override
  List<Object> get props => [];
}
