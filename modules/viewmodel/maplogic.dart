import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tophotels/modules/resources/app_colors.dart';

class Maplogic extends GetxController {
  //  varibles..........
  final List<Marker> _markers = <Marker>[];
  late BitmapDescriptor _personIcon;
  late BitmapDescriptor customIcon;
  void loadPersonIcon() async {
    // ignore: deprecated_member_use
    _personIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/svg/Avatar.png', // Path to your custom image
    );
    update();
  }

  void loadCustomIcon() async {
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 9.5), // Adjust size as needed
      'assets/svg/marker.png',
    );

    customIcon = icon;
    update();
  }

  void addDummyMarkers(LatLng center) async {
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
        _markers.add(
          Marker(
            draggable: true,
            markerId: MarkerId('dummy_person_$i'),
            position: positions[i],
            infoWindow: InfoWindow(title: 'Dummy Person $i'),
            icon: _personIcon,
            onTap: () => onDummyMarkerTapped(positions[i], i),
          ),
        );
        update();
      });
    }
  }

  void onDummyMarkerTapped(LatLng position, int markerId) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true, // Allows dynamic height adjustment
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5, // Adjust height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/cover_image.jpg'), // Replace with your cover image
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Circular profile image
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    'assets/svg/Avatar wrap.png'), // Replace with profile image
              ),
              const SizedBox(height: 20),
              // Text content
              Text(
                'Dummy Marker $markerId',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Action button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColors.primaryBlue,
                    minimumSize:
                        const Size(double.infinity, 50), // Full-width button
                  ),
                  child: const Text(
                    'Send Chips (s)',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Cancel button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )
            ],
          ),
        );
      },
    );
  }




}
