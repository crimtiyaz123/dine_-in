import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  String? _currentLocation;

  String? get currentLocation => _currentLocation;

  void setLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }

  Future<void> fetchCurrentLocation() async {
    // Implement location fetching logic
    _currentLocation = 'Current Location'; // Mock location
    notifyListeners();
  }
}
