import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;

import '../../../../../models/search_location_model.dart';

part 'select_location_event.dart';
part 'select_location_state.dart';

class SelectLocationBloc
    extends Bloc<SelectLocationEvent, SelectLocationState> {
  SelectLocationBloc() : super(SelectLocationInitialState()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    on<SearchEvent>(_getSearchLocation);
  }

  _getCurrentLocation(event, Emitter emit) async {
    // emit(SelectLocationInitialState());
    String currentAddress = "Click to get current location";

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        emit(SelectLocationErrorState("Location permission is denied"));
        // return;
      }

      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        emit(SelectLocationErrorState(
            "Location permission permanently denied. Please enable it from settings."));
        // return;
      }

      // Check if location services are enabled
      if (await Geolocator.isLocationServiceEnabled()) {
        emit(SelectLocationSuccessState(currentAddress));
        enableLocation();
      } else {
        permission = await Geolocator.requestPermission();
        emit(SelectLocationErrorState("Location services are disabled."));
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];

        currentAddress =
            '${place.subLocality}, ${place.locality},${place.administrativeArea},${place.postalCode}';
      }).catchError((e) {
        debugPrint(e);
      });

      emit(SelectLocationSuccessState(currentAddress));
    } catch (e) {
      emit(SelectLocationErrorState("Failed to fetch location: $e"));
    }
  }

  _getSearchLocation(event, Emitter emit) async {
    try {
      SearchLocationModel searchLocationModel =
          await getcategorynameid(event.searchKey);
      emit(SelectLocationSearchingState(searchLocationModel));
    } catch (e) {}
  }

  enableLocation() async {
    print("Log: enableLocation");
    loc.Location location =
        loc.Location(); //explicit reference to the Location class
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  Future<SearchLocationModel> getcategorynameid(String SearchKey) async {
    Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$SearchKey&components=country:in&radius=500&key=AIzaSyCJq_EIK9nmK1SHahnMofcnVkTFIe0U7cA");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SearchLocationModel.fromJson(data);
      }
    } catch (e) {
      throw Exception();
    }
    return throw Exception();
  }
}
