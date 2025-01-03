import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';

Future<Position> getUserCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  // Request location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get the current position
  return await Geolocator.getCurrentPosition();
}

Future<bool> showLocationServicesDialog() async {
  return await showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: const Text('Enable Location Services'),
      content: const Text(
          'Location services are turned off. Please enable them to continue.'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set custom border radius
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Open Settings',
            style: TextStyle(color: AppColors.primaryBlue),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.primaryBlue),
          ),
        ),
      ],
    ),
  );
}

Future<void> showLocationPermissionDialog(BuildContext context,
    {bool isDeniedForever = false}) async {
  String message = isDeniedForever
      ? 'Location permissions are permanently denied. Please enable them in settings.'
      : 'Location permission is required to continue. Please grant location access.';
  String buttonLabel = isDeniedForever ? 'Open Settings' : 'Retry';

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Location Access Required'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (isDeniedForever) {
              Geolocator.openAppSettings();
            }
          },
          child: Text(buttonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
