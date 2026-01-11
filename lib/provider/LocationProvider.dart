import 'package:flutter/material.dart';
import '../Services/location_service.dart';

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
    _city = location['city'] ?? 'Unknown';
    _area = location['area'] ?? '';
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshLocation() async {
    await fetchLocation();
  }
}
