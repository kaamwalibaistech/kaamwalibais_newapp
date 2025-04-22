part of 'select_location_bloc.dart';

abstract class SelectLocationEvent extends Equatable {}

class GetCurrentLocationEvent extends SelectLocationEvent {
  @override
  List<Object?> get props => [];
}

class SearchEvent extends SelectLocationEvent {
  final String searchKey;
  SearchEvent(this.searchKey);

  @override
  List<Object?> get props => [searchKey];
}

class SearchSelectedEvent extends SelectLocationEvent {
  final String selectedLocation = "";

  @override
  List<Object?> get props => [selectedLocation];
}
