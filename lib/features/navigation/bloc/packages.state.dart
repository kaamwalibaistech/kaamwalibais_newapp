import 'package:equatable/equatable.dart';
import 'package:kaamwalijobs_new/models/sortlisted_candidate_model.dart';

import '../../../models/current_package_plan.dart';

abstract class PackageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PackageIntitialState extends PackageState {
  @override
  List<Object?> get props => [];
}

class PackageLoadingState extends PackageState {
  @override
  List<Object?> get props => [];
}

class PackageLoadedStates extends PackageState {
  final CurrentPackagePlan currentPackagePlan;
  PackageLoadedStates({required this.currentPackagePlan});

  @override
  List<Object?> get props => [currentPackagePlan];
}

class PackageFailedState extends PackageState {
  final String errorMsg;
  PackageFailedState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

class SortListedCandidateLoadedState extends PackageState {
  final Shortlistedcandidatemodel sortListedCandidate;
  SortListedCandidateLoadedState({required this.sortListedCandidate});
  @override
  List<Object?> get props => [sortListedCandidate];
}

class SortListedCandidateloadingState extends PackageState {
  @override
  List<Object?> get props => [];
}

class SortListedCandidateFailedState extends PackageState {
  final String errorMsg;
  SortListedCandidateFailedState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}

// class CurrentJobsPackageInitialState extends PackageState {
//   @override
//   List<Object?> get props => [];
// }

// class CurrentJobsPackageLoadingState extends PackageState {
//   @override
//   List<Object?> get props => [];
// }

// class CurrentJobsPackageLoadedState extends PackageState {
//   final PurchasedpackagesJob purchasedpackagesJob;
//   CurrentJobsPackageLoadedState({required this.purchasedpackagesJob});
//   @override
//   List<Object?> get props => [];
// }

// class CurrentJobsPackageFailedState extends PackageState {
//   final String errorMsg;
//   CurrentJobsPackageFailedState({required this.errorMsg});
//   @override
//   List<Object?> get props => [];
// }
