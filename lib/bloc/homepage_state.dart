import 'package:equatable/equatable.dart';
import 'package:kaamwalijobs_new/models/homepage_model.dart';

abstract class HomepageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomePageInitialState extends HomepageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoadingState extends HomepageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoadedState extends HomepageState {
  final Homepagemodel homepagemodel;
  HomePageLoadedState({required this.homepagemodel});
  @override
  List<Object?> get props => [homepagemodel];
}

class HomePageFailedState extends HomepageState {
  @override
  List<Object?> get props => [];
}
