import 'package:google_maps_webservice/places.dart';

class GoogleAddressParser {
  GoogleAddress googleAddress = GoogleAddress();

  GoogleAddressParser(List<AddressComponent> addressComponents) {
    parseAddress(addressComponents);
  }

  void parseAddress(List<AddressComponent> addressComponents) {
    if (addressComponents.isEmpty) {
      throw Exception('Address Components is empty');
    }

    for (int i = 0; i < addressComponents.length; i++) {
      AddressComponent component = addressComponents[i];

      if (isStreetNumber(component)) {
        googleAddress.streetNumber = component.longName;
      }

      if (isStreetName(component)) {
        googleAddress.streetName = component.longName;
      }

      if (isCity(component)) {
        googleAddress.city = component.longName;
      }

      if (isCountry(component)) {
        googleAddress.country = component.longName;
        googleAddress.countryCode = component.shortName;
      }

      if (isState(component)) {
        googleAddress.state = component.longName;
        googleAddress.stateCode = component.shortName;
      }

      if (isPostalCode(component)) {
        googleAddress.postalCode = component.longName;
      }
    }
  }

  bool isStreetNumber(AddressComponent component) {
    return component.types.contains('street_number');
  }

  bool isStreetName(AddressComponent component) {
    return component.types.contains('route');
  }

  bool isCity(AddressComponent component) {
    return component.types.contains('locality') ||
        component.types.contains('postal_town');
  }

  bool isState(AddressComponent component) {
    return component.types.contains('administrative_area_level_1');
  }

  bool isCountry(AddressComponent component) {
    return component.types.contains('country');
  }

  bool isPostalCode(AddressComponent component) {
    return component.types.contains('postal_code');
  }

  GoogleAddress result() {
    return googleAddress;
  }
}

class GoogleAddress {
  String? streetNumber;
  String? streetName;
  String? city;
  String? country;
  String? countryCode;
  String? state;
  String? stateCode;
  String? postalCode;

  GoogleAddress({
    this.streetNumber,
    this.streetName,
    this.city,
    this.country,
    this.countryCode,
    this.state,
    this.stateCode,
    this.postalCode,
  });
}
