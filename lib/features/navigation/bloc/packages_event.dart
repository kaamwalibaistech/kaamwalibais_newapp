import 'package:equatable/equatable.dart';

abstract class PackageEvent extends Equatable {}

class PurchasedPackageEvent extends PackageEvent {
  @override
  List<Object?> get props => [];
}

// class PurchasedPackageJobEvent extends PackageEvent {
//   @override
//   List<Object?> get props => [];
// }

class SortListedCandidateEvent extends PackageEvent {
  final String? candidateId;
  final String? sortType;
  SortListedCandidateEvent({this.candidateId, this.sortType});

  @override
  List<Object?> get props => [candidateId];
}
