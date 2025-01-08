part of 'select_location_bloc.dart';

abstract class SelectLocationState {}

final class SelectLocationInitialState extends SelectLocationState {}

final class SelectLocationSearchingState extends SelectLocationState {}

final class SelectLocationSuccessState extends SelectLocationState {
  String address;
  SelectLocationSuccessState(this.address);
}

final class SelectLocationErrorState extends SelectLocationState {
  final String error;
  SelectLocationErrorState(this.error);
}
