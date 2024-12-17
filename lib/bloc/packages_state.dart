import 'package:equatable/equatable.dart';

import '../models/packages_model.dart';

abstract class PackagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PackagesInitialState extends PackagesState {
  @override
  List<Object?> get props => [];
}

class PackagesLoadingState extends PackagesState {
  @override
  List<Object?> get props => [];
}

class PackagesLoadedState extends PackagesState {
  final PackagesModel candidatePackagesModel;
  PackagesLoadedState({required this.candidatePackagesModel});

  @override
  List<Object?> get props => [candidatePackagesModel];
}

class PackagesFailedState extends PackagesState {
  @override
  List<Object?> get props => [];
}
