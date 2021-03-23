import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:async';
import 'dart:core';

class SearchPage{
  final context;
  final ValueChanged<LatLng> changeMarker;

  SearchPage(this.context, {this.changeMarker});

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> press() async {
    Prediction pred = await PlacesAutocomplete.show(
      context: context,
      apiKey: "AIzaSyBgGyEZProRd4VkkKgXiqELwCFLIizYLGM",
      onError: onError,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, "us")],
    );

    await displayPrediction(pred);
  }

  Future<Null> displayPrediction(Prediction prediction) async {
    if (prediction != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: "AIzaSyBgGyEZProRd4VkkKgXiqELwCFLIizYLGM",
        //apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
          prediction.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      LatLng pos = LatLng(lat, lng);
      changeMarker(pos);


    }
  }
}
