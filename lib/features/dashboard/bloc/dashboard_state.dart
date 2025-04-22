import 'package:equatable/equatable.dart';

import '../../../models/candidate_model.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardStateInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class CandidateListLoadingState extends DashboardState {
  CandidateListLoadingState();

  @override
  List<Object> get props => [];
}

class CandidateListLoadedState extends DashboardState {
  CandidateListLoadedState({required this.candidates});
  final List<CandidateData> candidates;
  @override
  List<Object> get props => [candidates];
}

class CategoryLisFailedState extends DashboardState {
  CategoryLisFailedState();

  @override
  List<Object> get props => [];
}

class CategoryListLoadingState extends DashboardState {
  CategoryListLoadingState();

  @override
  List<Object> get props => [];
}

class CategoryListLoadedState extends DashboardState {
  CategoryListLoadedState({required this.candidates});
  final List<CandidateData> candidates;
  @override
  List<Object> get props => [candidates];
}

class CandidateLisFailedState extends DashboardState {
  CandidateLisFailedState();

  @override
  List<Object> get props => [];
}
