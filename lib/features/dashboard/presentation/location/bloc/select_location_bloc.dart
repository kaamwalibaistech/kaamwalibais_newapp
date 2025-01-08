import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../models/search_location_model.dart';

part 'select_location_event.dart';
part 'select_location_state.dart';

class SelectLocationBloc
    extends Bloc<SelectLocationEvent, SelectLocationState> {
  SelectLocationBloc() : super(SelectLocationInitialState()) {
    on<GetCurrentLocationEvent>((event, emit) async {
      emit(SelectLocationInitialState());

      try {
        String currentAddress = "";
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            emit(SelectLocationErrorState("Location permission denied"));
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
          emit(SelectLocationErrorState(
              "Location permission permanently denied. Please enable it in settings."));
          return;
        }

        // Check if location services are enabled
        if (!await Geolocator.isLocationServiceEnabled()) {
          permission = await Geolocator.requestPermission();
          emit(SelectLocationErrorState("Location services are disabled."));
          return;
        }
        // Get current location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        await placemarkFromCoordinates(position.latitude, position.longitude)
            .then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];

          currentAddress =
              ' ${place.street}, ${place.subLocality}, ${place.locality}';
        }).catchError((e) {
          debugPrint(e);
        });

        emit(SelectLocationSuccessState(currentAddress));
      } catch (e) {
        emit(SelectLocationErrorState("Failed to fetch location: $e"));
      }
    });

    on<SearchEvent>((event, emit) {
      emit(SelectLocationInitialState());
      SelectLocationSearchingState();
    });
  }

//This api will be give city names based on input use to search
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
