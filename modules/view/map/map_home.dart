import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapHomePage extends StatefulWidget {
//   const MapHomePage({super.key});

//   @override
//   State<MapHomePage> createState() => _MapHomePageState();
// }

// class _MapHomePageState extends State<MapHomePage> {
//   final Completer<GoogleMapController> _controller = Completer();

//   List<Marker> _markers = <Marker>[];

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(33.6844, 73.0479),
//     zoom: 14,
//   );

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _markers.add(
//     //     Marker(
//     //         markerId: MarkerId('SomeId'),
//     //         position: LatLng(37.42796133580664, -122.085749655962),
//     //         infoWindow: InfoWindow(
//     //             title: 'The title of the marker'
//     //         )
//     //     )
//     // );
//     _markers.addAll(list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//           mapType: MapType.normal,
//           zoomControlsEnabled: true,
//           zoomGesturesEnabled: true,
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//           trafficEnabled: false,
//           rotateGesturesEnabled: true,
//           buildingsEnabled: true,
//           markers: Set<Marker>.of(_markers),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//     );
//   }
// }

// List<Marker> list = const [
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng(33.6844, 73.0479),
//       infoWindow: InfoWindow(title: 'Faislabad')),
//   Marker(
//       markerId: MarkerId('SomeId'),
//       position: LatLng(33.738045, 73.084488),
//       infoWindow: InfoWindow(title: 'e-11 islamabd')),
// ];

// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();

// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tophotels/modules/view/map/current_location.dart'; // Add geocoding for reverse geocoding

class MapHomePage extends StatefulWidget {
  final ValueNotifier<String> currentLocationNameNotifier;
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0.5);
  MapHomePage(
      {super.key,
      required this.currentLocationNameNotifier,
      required this.valueNotifier});

  @override
  State<MapHomePage> createState() => _MapHomePageState();
}

class _MapHomePageState extends State<MapHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final Set<Circle> _circles = {};

  // Initialize the ValueNotifier for CircularSeekBar
  // final ValueNotifier<double> _valueNotifier =
  //     ValueNotifier<double>(0.5); // Default value

  // Initial Camera Position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479), // Default location
    zoom: 18,
  );

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
    _startLocationUpdates(); // Start listening to location updates
    widget.valueNotifier.addListener(() {
      _onFilterValueChanged();
    });
  }

  void _startLocationUpdates() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen((Position position) {
      final userLatLng = LatLng(position.latitude, position.longitude);
      _updateUserLocation(userLatLng);
    });
  }

  void _updateUserLocation(LatLng userLatLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      userLatLng.latitude,
      userLatLng.longitude,
    );

    String locationName = "Unknown Location";
    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;
      locationName = [
        place.name,
        place.locality,
        place.administrativeArea,
        place.country
      ].where((element) => element != null && element.isNotEmpty).join(', ');

      widget.currentLocationNameNotifier.value = locationName;
    }

    setState(() {
      // Update marker
      _markers
          .removeWhere((marker) => marker.markerId.value == 'user_location');
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: userLatLng,
          infoWindow: InfoWindow(title: 'Your Location', snippet: locationName),
        ),
      );

      // Update circle
      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value);
    });
  }

  @override
  void dispose() {
    widget.valueNotifier.removeListener(_onFilterValueChanged);
    widget.valueNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadUserLocation() async {
    try {
      final position = await getUserCurrentLocation();
      final userLatLng = LatLng(position.latitude, position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final accurateLocationName = [
          place.name,
          place.locality,
          place.administrativeArea,
          place.country
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        // Update the currentLocationNameNotifier
        widget.currentLocationNameNotifier.value = accurateLocationName;
      }

      // Add the user marker and update circle
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: userLatLng,
          infoWindow: InfoWindow(
              title: 'Your Location',
              snippet: widget.currentLocationNameNotifier.value),
        ),
      );

      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value);

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: userLatLng,
        zoom: 14,
      )));

      setState(() {}); // Refresh the UI
    } catch (e) {
      print("Error fetching user location: $e");
    }
  }

  // Add or update a circle around a given position based on the filter value
  // void _addOrUpdateCircle(LatLng position, double filterValue) {
  //   // Remove existing circle if any
  //   _circles.removeWhere(
  //       (circle) => circle.circleId.value == 'user_location_circle');

  //   // Add new circle
  //   _circles.add(
  //     Circle(
  //       circleId: const CircleId('user_location_circle'),
  //       center: position,
  //       radius: _getCircleRadius(filterValue),
  //       fillColor: _getCircleColor(filterValue).withOpacity(0.5),
  //       strokeColor: _getCircleColor(filterValue),
  //       strokeWidth: 1,
  //     ),
  //   );
  // }

  // // Determine circle radius based on filter value
  double _getCircleRadius(double filterValue) {
    // Adjust these values as per your requirement
    if (filterValue < 0.3) return 100; // Low
    if (filterValue < 0.7) return 300; // Medium
    return 500; // High
  }

  // // Determine circle color based on filter value
  // Color _getCircleColor(double filterValue) {
  //   if (filterValue < 0.3) return Colors.green;
  //   if (filterValue < 0.7) return Colors.orange;
  //   return Colors.red;
  // }

  // // Handle changes in the filter's value
  // void _onFilterValueChanged() {
  //   final newValue = widget.valueNotifier.value;
  //   if (_markers.any((marker) => marker.markerId.value == 'user_location')) {
  //     final userMarker = _markers
  //         .firstWhere((marker) => marker.markerId.value == 'user_location');
  //     _addOrUpdateCircle(userMarker.position, newValue);
  //     setState(() {});
  //   }
  // }

  void _addOrUpdateCircle(LatLng position, double filterValue) {
    _circles.removeWhere(
        (circle) => circle.circleId.value == 'user_location_circle');

    _circles.add(
      Circle(
        circleId: const CircleId('user_location_circle'),
        center: position,
        radius: _getCircleRadius(filterValue),
        fillColor: _getCircleColor(filterValue).withOpacity(0.5),
        strokeColor: _getCircleColor(filterValue),
        strokeWidth: 1,
      ),
    );
  }

  Color _getCircleColor(double filterValue) {
    // Use the same logic as in FilterOptions to determine color
    if (filterValue <= 20) return Colors.green; // Low heat
    if (filterValue > 20 && filterValue <= 70)
      return Colors.yellow; // Medium heat
    return Colors.red; // High heat
  }

  void _onFilterValueChanged() {
    final newValue = widget.valueNotifier.value;
    if (_markers.any((marker) => marker.markerId.value == 'user_location')) {
      final userMarker = _markers
          .firstWhere((marker) => marker.markerId.value == 'user_location');
      _addOrUpdateCircle(userMarker.position, newValue);
      setState(() {}); // Update UI
    }
  }

  // Add marker dynamically when user taps on the map
  void _onMapTapped(LatLng tappedLatLng) async {
    // Fetch the address for the tapped location
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedLatLng.latitude,
      tappedLatLng.longitude,
    );

    String locationName = "Unknown Location";
    if (placemarks.isNotEmpty) {
      final Placemark place = placemarks.first;
      locationName = [
        place.name,
        place.locality,
        place.administrativeArea,
        place.country
      ].where((element) => element != null && element.isNotEmpty).join(', ');
    }

    // Update the marker and circle
    setState(() {
      // Remove any existing user location marker
      _markers
          .removeWhere((marker) => marker.markerId.value == 'user_location');

      // Add new marker at tapped position
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: tappedLatLng,
          infoWindow:
              InfoWindow(title: 'Tapped Location', snippet: locationName),
        ),
      );

      // Add or update circle based on new location
      _addOrUpdateCircle(tappedLatLng, widget.valueNotifier.value);
    });

    // Move camera to tapped position
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: tappedLatLng,
      zoom: 14,
    )));

    // Update location name in notifier
    widget.currentLocationNameNotifier.value = locationName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        circles: _circles,
        onTap: _onMapTapped, // Capture user tap to add a marker
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
