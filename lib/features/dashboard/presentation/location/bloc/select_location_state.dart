part of 'select_location_bloc.dart';

abstract class SelectLocationState extends Equatable {}

final class SelectLocationInitialState extends SelectLocationState {
  @override
  List<Object?> get props => [];
}

final class SelectLocationSearchingState extends SelectLocationState {
  final SearchLocationModel? searchLocationModel;
  SelectLocationSearchingState(this.searchLocationModel);

  @override
  List<Object?> get props => [searchLocationModel];
}

final class SelectLocationSuccessState extends SelectLocationState {
  final String currentAddress;

  SelectLocationSuccessState(this.currentAddress);

  @override
  List<Object?> get props => [currentAddress];
}

final class SelectLocationErrorState extends SelectLocationState {
  final String error;
  SelectLocationErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
