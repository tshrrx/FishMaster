import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  @override
  String toString() => 'LatLng($latitude, $longitude)';
}

class GeofenceService extends GetxService {
  static bool disableGeofence = false;
  StreamSubscription<Position>? _positionSubscription;
  bool _wasNearBorder = false;
  bool _wasOutside = false;
  bool _wasInRestrictedArea = false;

  // Maritime border coordinates (Sri Lanka)
  final List<LatLng> borderCoordinates = [
    LatLng(9.959844, 79.826441), LatLng(9.800999, 79.563088), LatLng(9.904257, 79.718950),
    LatLng(9.589087, 79.407226), LatLng(9.1, 79.32), LatLng(9.0, 79.31),
    LatLng(8.88, 79.29), LatLng(8.67, 79.18), LatLng(8.62, 79.13),
    LatLng(8.53, 79.04), LatLng(8.37, 78.92), LatLng(8.2, 78.92),
    LatLng(7.58, 78.75), LatLng(7.35, 78.64), LatLng(7.21, 78.38),
    LatLng(6.52, 78.12), LatLng(5.89, 77.85), LatLng(5.0, 77.18),
    LatLng(8.0, 73.0), LatLng(20.0, 68.0), LatLng(22.0, 68.0),
    LatLng(23.98, 68.48), LatLng(21.79, 89.09), LatLng(21.19, 88.58),
    LatLng(20.44, 89.02), LatLng(20.12, 89.06), LatLng(11.43, 83.37),
    LatLng(11.16, 82.41), LatLng(11.27, 81.93), LatLng(11.05, 81.93),
    LatLng(10.69, 81.04), LatLng(10.55, 80.77), LatLng(10.08, 80.09),
    LatLng(10.05, 80.05), LatLng(10.05, 80.03)
  ];

  // Restricted areas (Gulf of Mannar)
  final List<List<LatLng>> restrictedAreas = [
    [
      LatLng(9.40, 78.50), // Coastal region of Tamil Nadu
      LatLng(9.30, 79.00), // North of Gulf of Mannar
      LatLng(8.80, 79.80), // Midway in the Gulf
      LatLng(8.50, 80.30), // Northern Sri Lanka coast
      LatLng(8.00, 79.60), // Central Gulf waters
      LatLng(8.10, 78.90), // South-West of the Gulf
      LatLng(8.50, 78.50), // South Tamil Nadu coast
      LatLng(9.00, 78.00), // Western boundary
    ],
  ];

  /// Initialize the service
  Future<GeofenceService> init() async {
    await _checkLocationPermission();
    return this;
  }

  /// Check and request location permissions
  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showServiceDisabledWarning();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        await _showPermissionDeniedWarning();
        return;
      }
    }
    _startLocationUpdates();
  }

  /// Start listening to location updates
  void _startLocationUpdates() {
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 50, // Update every 50 meters
      ),
    ).listen((Position position) {
      _handleNewPosition(position);
    }, onError: (error) {
      _showLocationError(error.toString());
    });
  }

  /// Process new position updates
  void _handleNewPosition(Position position) {
    if (disableGeofence) return; // Skip processing if disabled

    final currentLocation = LatLng(position.latitude, position.longitude);
    final bool isInsideBorder = isPointInPolygon(currentLocation, borderCoordinates);
    final double distanceToBorder = computeMinDistanceToBorder(currentLocation);
    final bool isInRestrictedArea = restrictedAreas.any((area) =>
        isPointInPolygon(currentLocation, area));

    if (distanceToBorder <= 1000 && !_wasNearBorder) {
      _showProximityWarning(distanceToBorder);
      _wasNearBorder = true;
    } else if (distanceToBorder > 1000 && _wasNearBorder) {
      _wasNearBorder = false;
    }

    if (!isInsideBorder && !_wasOutside) {
      _showBorderCrossingWarning();
      _wasOutside = true;
    } else if (isInsideBorder && _wasOutside) {
      _wasOutside = false;
    }

    if (isInRestrictedArea && !_wasInRestrictedArea) {
      _showRestrictedAreaWarning();
      _wasInRestrictedArea = true;
    } else if (!isInRestrictedArea && _wasInRestrictedArea) {
      _wasInRestrictedArea = false;
    }
  }

  /// Check if point is inside polygon
  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    bool inside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      final LatLng a = polygon[i];
      final LatLng b = polygon[j];

      if ((a.latitude > point.latitude) != (b.latitude > point.latitude)) {
        final double t = (point.latitude - a.latitude) / (b.latitude - a.latitude);
        final double lng = a.longitude + t * (b.longitude - a.longitude);
        if (lng < point.longitude) inside = !inside;
      }
    }
    return inside;
  }

  /// Calculate minimum distance to border (in meters)
  double computeMinDistanceToBorder(LatLng point) {
    double minDistance = double.infinity;

    for (int i = 0; i < borderCoordinates.length; i++) {
      final LatLng a = borderCoordinates[i];
      final LatLng b = borderCoordinates[(i + 1) % borderCoordinates.length];
      final double edgeDistance = _distanceToEdge(point, a, b);

      if (edgeDistance < minDistance) {
        minDistance = edgeDistance;
      }
    }
    return minDistance;
  }

  /// Calculate distance from point to edge
  double _distanceToEdge(LatLng p, LatLng a, LatLng b) {
    final double dAP = Geolocator.distanceBetween(
        a.latitude, a.longitude, p.latitude, p.longitude);
    final double dBP = Geolocator.distanceBetween(
        b.latitude, b.longitude, p.latitude, p.longitude);
    final double dAB = Geolocator.distanceBetween(
        a.latitude, a.longitude, b.latitude, b.longitude);

    if (dAB == 0) return dAP;

    final double thetaAB = Geolocator.bearingBetween(
        a.latitude, a.longitude, b.latitude, b.longitude);
    final double thetaAP = Geolocator.bearingBetween(
        a.latitude, a.longitude, p.latitude, p.longitude);
    final double deltaTheta = (thetaAP - thetaAB) * pi / 180;
    final double deltaAP = dAP / 6371000;

    double product = sin(deltaAP) * sin(deltaTheta);
    product = product.clamp(-1.0, 1.0);
    final double dxt = asin(product).abs() * 6371000;

    final double cosDxt = cos(dxt / 6371000);
    final double dat = cosDxt != 0
        ? acos(cos(deltaAP) / cosDxt) * 6371000
        : double.infinity;

    return (dat >= 0 && dat <= dAB) ? dxt : min(dAP, dBP);
  }

  // Alert Methods --------------------------------------------------------------

  void _showProximityWarning(double distance) {
    _showAlert(
      title: "Border Proximity Alert",
      message: "You are ${distance.toStringAsFixed(0)} meters from the maritime border. "
          "Proceed with caution.",
      color: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }

  void _showBorderCrossingWarning() {
    _showAlert(
      title: "Border Crossed!",
      message: "You have crossed the international maritime border. "
          "Return back to Indian border immediately.",
      color: Colors.red,
      icon: Icons.error_outline,
    );
  }

  void _showRestrictedAreaWarning() {
    _showAlert(
      title: "Restricted Area Entered",
      message: "You have entered the Gulf of Mannar restricted zone. "
          "Special fishing regulations apply in this area.",
      color: Colors.purple,
      icon: Icons.do_not_disturb_on,
    );
  }

  Future<void> _showServiceDisabledWarning() async {
    await _showAlert(
      title: "Location Services Disabled",
      message: "Please enable location services for border alerts to work properly.",
      color: Colors.blue,
      icon: Icons.location_off,
    );
  }

  Future<void> _showPermissionDeniedWarning() async {
    await _showAlert(
      title: "Location Permission Required",
      message: "The app needs location permissions to monitor your position "
          "near maritime borders.",
      color: Colors.blue,
      icon: Icons.perm_device_information,
    );
  }

  void _showLocationError(String error) {
    _showAlert(
      title: "Location Error",
      message: "Could not determine your position: $error",
      color: Colors.red,
      icon: Icons.gps_off,
    );
  }

  Future<void> _showAlert({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) async {
    // Wait for overlay context to be available
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return Get.overlayContext == null;
    });

    if (!Get.isDialogOpen!) {
      await Get.dialog(
        AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(color: color)),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("OK", style: TextStyle(color: color)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  @override
  void onClose() {
    _positionSubscription?.cancel();
    super.onClose();
  }
}