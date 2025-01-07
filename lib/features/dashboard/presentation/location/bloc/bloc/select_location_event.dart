part of 'select_location_bloc.dart';

abstract class SelectLocationEvent {}

class GetCurrentLocationEvent extends SelectLocationEvent {}

class SearchEvent extends SelectLocationEvent {
  late String searchLocation;
}

class SearchSelectedEvent extends SelectLocationEvent {
  late String selectedLocation;
}
