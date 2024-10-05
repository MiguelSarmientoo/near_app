import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;

  double get latitude => _latitude;
  double get longitude => _longitude;

  void updateLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
    notifyListeners();
  }
}
