import 'dart:async';
import 'dart:math';
import 'dart:ui';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/map/current_location.dart';
import 'package:tophotels/modules/viewmodel/chip_logic.dart';
import 'package:tophotels/modules/viewmodel/maplogic.dart'; // Add geocoding for reverse geocoding

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
  final controller = Get.put(Maplogic());
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final Set<Circle> _circles = {};

  // Initial Camera Position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479), // Default location
    zoom: 18,
  );
  late List<BitmapDescriptor> personIcons = [];
  late BitmapDescriptor customIcon;
  late BitmapDescriptor markerIcon1;
  late BitmapDescriptor markerIcon2;
  @override
  void initState() {
    super.initState();
    _checkLocationServiceStatus();
    Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        // Location services enabled, call loadUserLocation again
        loadUserLocation();
      }
    });
    _startLocationUpdates(); // Start listening to location updates
    widget.valueNotifier.addListener(() {
      _onFilterValueChanged();
    });
    widget.distanceNotifier.addListener(() {
      _onFilterValueChanged();
    });
    _loadPersonIcons();
    _loadCustomIcon();
    _initializeMarkerIcons();
  }

  @override
  void dispose() {
    widget.valueNotifier.removeListener(_onFilterValueChanged);
    widget.valueNotifier.dispose();
    widget.distanceNotifier.dispose();
    super.dispose();
  }

// load markercustom.....
  Future<BitmapDescriptor> _loadMarkerIcon(String assetPath) async {
    // Load the image as bytes
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    // Resize the image
    final image = await decodeImageFromList(Uint8List.fromList(bytes));

    // Convert the resized image into a BitmapDescriptor
    final resizedImage = await image.toByteData(format: ImageByteFormat.png);
    final resizedBytes = resizedImage!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void _initializeMarkerIcons() async {
    markerIcon1 = await _loadMarkerIcon('assets/svg/Group 4200.png');
    markerIcon2 = await _loadMarkerIcon('assets/svg/Group 4199.png');

    setState(() {}); // Ensure UI is updated after loading icons
  }

  void _loadCustomIcon() async {
    // Load the image as bytes
    final ByteData data = await rootBundle.load('assets/svg/marker.png');
    final List<int> bytes = data.buffer.asUint8List();

    // Resize the image
    final image = await decodeImageFromList(Uint8List.fromList(bytes));

    // Resize the image to a specific width and height
    final resizedImage = await image.toByteData(format: ImageByteFormat.png);
    final resizedBytes = resizedImage!.buffer.asUint8List();

    // Convert the resized image into a BitmapDescriptor
    BitmapDescriptor icon = BitmapDescriptor.fromBytes(resizedBytes);

    setState(() {
      customIcon = icon;
    });
  }

// Function to load the person image as a BitmapDescriptor
  void _loadPersonIcons() async {
    // List of image paths for different markers
    List<String> imagePaths = [
      'assets/svg/Avatar.png',
      'assets/svg/Avatar-1.png',
      'assets/svg/Avatar-2.png',
      'assets/svg/Avatar-3.png',
      'assets/svg/Avatar-4.png',
      'assets/svg/Avatar-5.png',
      // Add more image paths if necessary
    ];

    // Load and resize each image, then store it in the _personIcons list
    for (String path in imagePaths) {
      final ByteData data = await rootBundle.load(path);
      final List<int> bytes = data.buffer.asUint8List();

      final image = await decodeImageFromList(Uint8List.fromList(bytes));
      final resizedImage = await image.toByteData(format: ImageByteFormat.png);
      final resizedBytes = resizedImage!.buffer.asUint8List();

      BitmapDescriptor icon = BitmapDescriptor.fromBytes(resizedBytes);

      setState(() {
        personIcons.add(icon); // Add the icon to the list
      });
    }
  }

  void _addDummyMarkers(LatLng center) async {
    const double circleRadius = 0.002; // Radius of the circle for markers
    const int delayBetweenMarkers = 500; // Delay in milliseconds

    final positions = [
      // Right circle positions (3 markers)
      LatLng(center.latitude, center.longitude + circleRadius),
      LatLng(center.latitude + circleRadius * 0.866,
          center.longitude + circleRadius * 0.5),
      LatLng(center.latitude - circleRadius * 0.866,
          center.longitude + circleRadius * 0.5),

      // Bottom circle positions (2 markers)
      LatLng(center.latitude - circleRadius, center.longitude),
      LatLng(center.latitude - circleRadius * 0.866,
          center.longitude - circleRadius * 0.5),

      // Top position (1 marker)
      LatLng(center.latitude + circleRadius * 1.5, center.longitude),
    ];

    for (int i = 0; i < positions.length; i++) {
      await Future.delayed(const Duration(milliseconds: delayBetweenMarkers),
          () {
        setState(() {
          _markers.add(
            Marker(
                draggable: true,
                markerId: MarkerId('dummy_person_$i'),
                position: positions[i],
                infoWindow: InfoWindow(title: 'Person $i'),
                icon: personIcons[i],
                onTap: () {
                  // controller.infoBottomSheet();
                  if (i == 0) {
                    ChipLogic().merchentSheet();
                  } else if (i == 1) {
                    ChipLogic().reciveChiipSheet();
                  } else {
                    controller.infoBottomSheet();
                  }
                }),
          );
        });
      });
    }
  }

  // void _onDummyMarkerTapped(LatLng position, int markerId) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true, // Allows dynamic height adjustment
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.4, // Adjust height
  //         decoration: const BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage(
  //                 'assets/images/cover_image.jpg'), // Replace with your cover image
  //             fit: BoxFit.cover,
  //           ),
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //         ),
  //         child: Column(
  //           children: [
  //             const SizedBox(height: 20),
  //             // Circular profile image
  //             const CircleAvatar(
  //               radius: 30,
  //               backgroundImage: AssetImage(
  //                   'assets/svg/Avatar wrap.png'), // Replace with profile image
  //             ),
  //             const SizedBox(height: 20),
  //             // Text content
  //             Text(
  //               'Person $markerId',
  //               style: const TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.black,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 40),
  //             // Action button
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Close the bottom sheet
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10)),
  //                   backgroundColor: AppColors.primaryBlue,
  //                   minimumSize:
  //                       const Size(double.infinity, 50), // Full-width button
  //                 ),
  //                 child: const Text(
  //                   'Close',
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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

  LatLng calculateNewCoordinates(
      LatLng origin, double distanceInMeters, double bearingInDegrees) {
    const double earthRadius = 6371000; // Earth's radius in meters
    final double distanceInRadians = distanceInMeters / earthRadius;
    final double bearingInRadians = bearingInDegrees * (pi / 180);

    final double originLatRadians = origin.latitude * (pi / 180);
    final double originLngRadians = origin.longitude * (pi / 180);

    final double newLatRadians = asin(sin(originLatRadians) *
            cos(distanceInRadians) +
        cos(originLatRadians) * sin(distanceInRadians) * cos(bearingInRadians));
    final double newLngRadians = originLngRadians +
        atan2(
            sin(bearingInRadians) *
                sin(distanceInRadians) *
                cos(originLatRadians),
            cos(distanceInRadians) -
                sin(originLatRadians) * sin(newLatRadians));

    final double newLat = newLatRadians * (180 / pi);
    final double newLng = newLngRadians * (180 / pi);
    return LatLng(newLat, newLng);
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
      // Remove existing user location marker
      _markers
          .removeWhere((marker) => marker.markerId.value == 'user_location');
      _markers.add(
        Marker(
          icon: customIcon,
          markerId: const MarkerId('user_location'),
          position: userLatLng,
          infoWindow: InfoWindow(title: 'Your Location', snippet: locationName),
        ),
      );

      // Add two more markers outside the circles
      final LatLng marker1Position =
          calculateNewCoordinates(userLatLng, 1000, 270); // 1km away at 45°
      final LatLng marker2Position =
          calculateNewCoordinates(userLatLng, 1200, 215); // 1.2km away at 135°

      _markers.addAll([
        Marker(
          markerId: const MarkerId('extra_marker_1'),
          position: marker1Position,
          icon: markerIcon2,
          infoWindow:
              const InfoWindow(title: 'Marker 1', snippet: 'Outside Circle'),
        ),
        Marker(
          markerId: const MarkerId('extra_marker_2'),
          position: marker2Position,
          icon: markerIcon1,
          infoWindow:
              const InfoWindow(title: 'Marker 2', snippet: 'Outside Circle'),
        ),
      ]);

      // Update the circle
      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value,
          widget.distanceNotifier.value);
    });
  }

  bool isLocationServiceEnabled = false;
//  chekc service...............
  Future<void> _checkLocationServiceStatus() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      loadUserLocation();
    } else {
      // _showSnackBar('Please enable location services to continue.');
    }
  }

  Future<void> loadUserLocation() async {
    try {
      // Check if location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: const Text(
        //         'Location services are disabled. Please enable them in settings.'),
        //     duration: const Duration(seconds: 3),
        //     behavior: SnackBarBehavior.floating,
        //     backgroundColor: AppColors.primaryBlue.withOpacity(0.8),
        //   ),
        // );
        return;
      }

      // Check current location permission status
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.always &&
            permission != LocationPermission.whileInUse) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: const Text(
          //         'Location permission is required to continue. Please allow it.'),
          //     duration: const Duration(seconds: 3),
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: AppColors.primaryBlue.withOpacity(0.8),
          //   ),
          // );
          return;
        }
      }

      // Fetch the user's current location
      final position = await getUserCurrentLocation();
      final userLatLng = LatLng(position.latitude, position.longitude);

      // Get the placemark for the location
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

      // Add the user marker
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: userLatLng,
          icon: customIcon,
          infoWindow: InfoWindow(
              title: 'Your Location',
              snippet: widget.currentLocationNameNotifier.value),
        ),
      );

      // Update the circle and markers
      _addOrUpdateCircle(userLatLng, widget.valueNotifier.value,
          widget.distanceNotifier.value);

      // Animate camera to user's current location
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

  void _addOrUpdateCircle(
      LatLng position, double filterValue, double distanceValue) {
    // Remove existing gradient circles
    _circles.removeWhere(
        (circle) => circle.circleId.value.startsWith('gradient_circle'));

    // Define gradient colors for heat filter (inner circle)
    List<Color> colors;
    if (filterValue <= 20) {
      colors = [
        const Color(0xFFFF0066),
        const Color(0xFFEBA857),
      ];
    } else if (filterValue > 20 && filterValue <= 70) {
      colors = [
        const Color(0xFF5799D6),
        const Color(0xFF5ACBD2),
      ];
    } else {
      colors = [
        const Color(0xFF4DCEB7),
      ];
    }

    // Add dummy markers (assuming you need them)
    _addDummyMarkers(position);

    // Add multiple circles to simulate a gradient (Inner heat circle)
    for (int i = 0; i < colors.length; i++) {
      final radius = 400 - i * (distanceValue);
      if (radius > 0) {
        // Ensure the radius doesn't go negative or too small
        _circles.add(
          Circle(
            circleId: CircleId('gradient_circle_heat_$i'),
            center: position,
            radius: 600, // Adjust radius for the inner heat circle
            fillColor: colors[i].withOpacity(0.2), // Inner circle color
            strokeColor: Colors.transparent,
            strokeWidth: 0,
          ),
        );
      }
    }

    // Define separate colors for the distance circle (outer circle)
    List<Color> distanceColors;
    if (distanceValue <= 50) {
      distanceColors = [
        const Color(0xFF4DCEB7), // Light blue for small distances
      ];
    } else {
      distanceColors = [
        const Color(0xFFEDA659), // Dark blue for larger distances
      ];
    }

    // Add the outer circle with fixed radius of 400
    _circles.add(
      Circle(
        circleId: const CircleId('gradient_circle_distance'),
        center: position,
        radius: distanceValue, // Adjust radius for the outer circle
        fillColor: distanceColors.first
            .withOpacity(0.4), // Separate color for outer circle
        strokeColor: Colors.transparent, // Outer circle stroke color
        strokeWidth: 2,
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
          icon: customIcon,
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
    // Add two more markers outside the circles
    final LatLng marker1Position =
        calculateNewCoordinates(tappedLatLng, 1000, 270); // 1km away at 45°
    final LatLng marker2Position =
        calculateNewCoordinates(tappedLatLng, 1200, 215); // 1.2km away at 135°

    _markers.addAll([
      Marker(
        markerId: const MarkerId('extra_marker_1'),
        position: marker1Position,
        icon: markerIcon2,
        infoWindow:
            const InfoWindow(title: 'Marker 1', snippet: 'Outside Circle'),
      ),
      Marker(
        markerId: const MarkerId('extra_marker_2'),
        position: marker2Position,
        icon: markerIcon1,
        infoWindow:
            const InfoWindow(title: 'Marker 2', snippet: 'Outside Circle'),
      ),
    ]);

    // if ( widget.distanceNotifier.value) {
    // Add dummy person markers
    _addDummyMarkers(tappedLatLng);
    // }
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
    return GetBuilder<Maplogic>(builder: (controller) {
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
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            }
          },
        ),
      );
    });
  }
}
