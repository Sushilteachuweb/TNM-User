// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<bool> checkAndRequestLocationPermission() async {
    // Location disabled for now
    return false;
    
    /*
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
    */
  }

  static Future<Map<String, String>> getCurrentLocation() async {
    // Return default location since geolocation is disabled
    return {
      'city': 'Location Skipped', // Or empty string if preferred
      'area': '',
    };
    
    /*
    try {
      bool hasPermission = await checkAndRequestLocationPermission();
      
      if (!hasPermission) {
        return {
          'city': 'Location Disabled',
          'area': 'Enable location to continue',
        };
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return {
          'city': place.locality ?? 'Unknown',
          'area': place.subLocality ?? place.administrativeArea ?? '',
        };
      }

      return {
        'city': 'Unknown',
        'area': '',
      };
    } catch (e) {
      return {
        'city': 'Error',
        'area': 'Unable to fetch location',
      };
    }
    */
  }

  static Future<void> openLocationSettings() async {
    // await Geolocator.openLocationSettings();
  }
}
