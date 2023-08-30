import 'package:antenasur/models/radio_station.dart';
import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  final RadioStation initialRadioStation;

  RadioProvider(this.initialRadioStation);

  RadioStation? _station;
  RadioStation get station => _station ?? initialRadioStation;

  void setRadioStation(RadioStation station) {
    _station = station;
    notifyListeners();
  }
}
