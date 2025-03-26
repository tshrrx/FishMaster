import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Calculates the bearing between two [LatLng] points in degrees.
double calculateBearing(LatLng start, LatLng end) {
  double startLat = start.latitude * pi / 180;
  double startLng = start.longitude * pi / 180;
  double endLat = end.latitude * pi / 180;
  double endLng = end.longitude * pi / 180;

  double dLng = endLng - startLng;
  double y = sin(dLng) * cos(endLat);
  double x = cos(startLat) * sin(endLat) - sin(startLat) * cos(endLat) * cos(dLng);
  double bearing = atan2(y, x) * 180 / pi;
  return (bearing + 360) % 360;
}

/// Optionally, calculates the haversine distance (in kilometers) between two points.
double calculateDistance(LatLng start, LatLng end) {
  const double R = 6371; // Earth's radius in km
  double dLat = (end.latitude - start.latitude) * pi / 180;
  double dLon = (end.longitude - start.longitude) * pi / 180;
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(start.latitude * pi / 180) *
          cos(end.latitude * pi / 180) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}
