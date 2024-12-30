import 'dart:async';

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
  ValueNotifier<double> distanceNotifier = ValueNotifier<double>(0.0);
  MapHomePage(
      {super.key,
      required this.currentLocationNameNotifier,
      required this.valueNotifier,
      required this.distanceNotifier});

  @override
  State<MapHomePage> createState() => _MapHomePageState();
}

class _MapHomePageState extends State<MapHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final Set<Circle> _circles = {};

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
      // _addOrUpdateCircle(userLatLng, widget.valueNotifier.value);
      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value,
          widget.distanceNotifier.value);
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

      // _addOrUpdateCircle(userLatLng, widget.valueNotifier.value);
      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value,
          widget.distanceNotifier.value);

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

  // void _addOrUpdateCircle(LatLng position, double filterValue) {
  //   _circles.removeWhere(
  //       (circle) => circle.circleId.value.startsWith('gradient_circle'));

  //   // Define gradient colors and stops
  //   List<Color> colors;
  //   if (filterValue <= 20) {
  //     colors = [
  //       Colors.green.shade200.withOpacity(0.3),
  //       Colors.green.withOpacity(0.3)
  //     ];
  //   } else if (filterValue > 20 && filterValue <= 70) {
  //     colors = [
  //       Colors.yellow.shade200.withOpacity(0.3),
  //       Colors.yellow.withOpacity(0.3)
  //     ];
  //   } else {
  //     colors = [
  //       Colors.red.shade200.withOpacity(0.3),
  //       Colors.red.withOpacity(0.3)
  //     ];
  //   }

  //   // Add multiple circles to simulate a gradient
  //   for (int i = 0; i < colors.length; i++) {
  //     _circles.add(
  //       Circle(
  //         circleId: CircleId('gradient_circle_$i'),
  //         center: position,
  //         radius: 1000 - (i * 200), // Adjust radius for layers
  //         fillColor: colors[i],
  //         strokeColor: Colors.transparent,
  //         strokeWidth: 0,
  //       ),
  //     );
  //   }
  // }
  void _addOrUpdateCircle(
      LatLng position, double filterValue, double distanceValue) {
    // Remove existing gradient circles
    _circles.removeWhere(
        (circle) => circle.circleId.value.startsWith('gradient_circle'));

    // Define gradient colors for heat filter
    List<Color> colors;
    if (filterValue <= 20) {
      colors = [
        const Color(0xFFFF7C6F),
        const Color(0xFFEBA857),
      ];
    } else if (filterValue > 20 && filterValue <= 70) {
      colors = [
        const Color(0xFF5799D6),
        const Color(0xFF5ACBD2),
      ];
    } else {
      colors = [
        const Color(0xFF5799D6),
        const Color(0xFF5ACBD2),
      ];
    }

    // Add multiple circles to simulate a gradient (Inner circle - heat filter)
    for (int i = 0; i < colors.length; i++) {
      _circles.add(
        Circle(
          circleId: CircleId('gradient_circle_heat_$i'),
          center: position,
          // radius: distanceValue,
          radius: 800 -
              (i *
                  (widget.distanceNotifier.value)), // Adjust radius for inner heat circle
          fillColor: colors[i].withOpacity(0.4),
          strokeColor: Colors.transparent,
          strokeWidth: 0,
        ),
      );
    }

    // Update the outer circle for distance filter
    _circles.add(
      Circle(
        circleId: const CircleId('gradient_circle_distance'),
        center: position,
        radius: distanceValue, // Apply the distance value to the radius
        fillColor: Colors.transparent,
        strokeColor: Colors.blue.withOpacity(0.5), // You can change this color
        strokeWidth: 0,
      ),
    );
  }

  void _onFilterValueChanged() {
    final newValue = widget.valueNotifier.value; // Heat filter value
    final distanceValue =
        widget.distanceNotifier.value; // Distance filter value

    // Check if the user location marker exists
    if (_markers.any((marker) => marker.markerId.value == 'user_location')) {
      final userMarker = _markers
          .firstWhere((marker) => marker.markerId.value == 'user_location');

      // Apply the updated logic for circle with both filters
      _addOrUpdateCircle(userMarker.position, newValue, distanceValue);

      setState(() {}); // Refresh UI
    }
  }

  // void _onFilterValueChanged() {
  //   final newValue = widget.valueNotifier.value;
  //   if (_markers.any((marker) => marker.markerId.value == 'user_location')) {
  //     final userMarker = _markers
  //         .firstWhere((marker) => marker.markerId.value == 'user_location');
  //     _addOrUpdateCircle(userMarker.position, newValue);
  //     setState(() {}); // Update UI
  //   }
  // }

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
      // _addOrUpdateCircle(tappedLatLng, widget.valueNotifier.value);
      _addOrUpdateCircle(tappedLatLng, widget.valueNotifier.value,
          widget.distanceNotifier.value);
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
