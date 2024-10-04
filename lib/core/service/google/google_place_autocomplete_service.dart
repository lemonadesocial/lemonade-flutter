import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:app/core/config.dart';

class GooglePlaceAutocompleteService {
  late GoogleMapsPlaces _placesApi;

  GooglePlaceAutocompleteService() {
    _initPlacesApi();
  }

  Future<void> _initPlacesApi() async {
    _placesApi = GoogleMapsPlaces(
      apiKey: AppConfig.googleMapKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
  }

  Future<List<Prediction>> getAutocompleteSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final response = await _placesApi.autocomplete(
      query,
      language: 'en',
    );

    if (response.isOkay) {
      return response.predictions;
    } else {
      throw Exception('Failed to fetch autocomplete suggestions');
    }
  }

  Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
    final response = await _placesApi.getDetailsByPlaceId(placeId);

    if (response.isOkay) {
      return response;
    } else {
      throw Exception('Failed to fetch place details');
    }
  }
}
