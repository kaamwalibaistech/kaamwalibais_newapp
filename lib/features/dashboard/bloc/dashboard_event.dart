import 'package:equatable/equatable.dart';

import '../../../models/candidate_request.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCandidates extends DashboardEvent {
  GetCandidates({required this.candidateRequest});
  final CandidateRequest candidateRequest;
  @override
  List<Object> get props => [];
}
