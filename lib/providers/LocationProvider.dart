import 'package:flutter/material.dart';
import '../services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  String _city = 'Fetching...';
  String _area = '';
  bool _isLoading = true;

  String get city => _city;
  String get area => _area;
  bool get isLoading => _isLoading;

  Future<void> fetchLocation() async {
    _isLoading = true;
    notifyListeners();

    final location = await LocationService.getCurrentLocation();
    _city = location;
    _area = 'Area';
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshLocation() async {
    await fetchLocation();
  }
}
