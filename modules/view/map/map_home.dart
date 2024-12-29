import 'dart:async';

import 'package:flutter/material.dart';
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
import 'package:geocoding/geocoding.dart'; // Add geocoding for reverse geocoding

class MapHomePage extends StatefulWidget {
  const MapHomePage({super.key});

  @override
  State<MapHomePage> createState() => _MapHomePageState();
}

class _MapHomePageState extends State<MapHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6844, 73.0479), // Initial location
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _loadDefaultMarkers();
  }

  // Load default markers
  void _loadDefaultMarkers() {
    _markers = [
      const Marker(
        markerId: MarkerId('faisalabad'),
        position: LatLng(31.4187, 73.0791),
        infoWindow: InfoWindow(title: 'Faisalabad, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('islamabad'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(title: 'Islamabad, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('lahore'),
        position: LatLng(31.5497, 74.3436),
        infoWindow: InfoWindow(title: 'Lahore, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('karachi'),
        position: LatLng(24.8607, 67.0011),
        infoWindow: InfoWindow(title: 'Karachi, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('multan'),
        position: LatLng(30.1575, 71.5249),
        infoWindow: InfoWindow(title: 'Multan, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('peshawar'),
        position: LatLng(34.0151, 71.5249),
        infoWindow: InfoWindow(title: 'Peshawar, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('abbottabad'),
        position: LatLng(34.1463, 73.2140),
        infoWindow: InfoWindow(title: 'Abbottabad, Pakistan'),
      ),
      const Marker(
        markerId: MarkerId('rawalpindi'),
        position: LatLng(33.6007, 73.0679),
        infoWindow: InfoWindow(title: 'Rawalpindi, Pakistan'),
      ),
    ];
  }

  // Add marker dynamically when user taps
  void _addMarker(LatLng position) async {
    String address = "Unknown location";
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        address = placemarks.first.locality ?? address;
      }
    } catch (e) {
      print("Error fetching address: $e");
    }

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(title: address),
        ),
      );
    });
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
        onTap: _addMarker, // Capture user tap to add a marker
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
