import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/filter.dart';
import 'package:tophotels/modules/view/map/current_location.dart';
import 'package:tophotels/modules/view/map/map_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool replce = false;
  final ValueNotifier<String> _currentLocationNameNotifier =
      ValueNotifier<String>('Unknown Location');
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  final ValueNotifier<double> _distanceNotifier = ValueNotifier(0.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Image
          MapHomePage(
            distanceNotifier: _distanceNotifier,
            valueNotifier: _valueNotifier,
            currentLocationNameNotifier: _currentLocationNameNotifier,
          ),

          // Overlay content
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Text Field
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _currentLocationNameNotifier,
                        builder: (context, currentLocationName, child) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                getUserCurrentLocation();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color
                                borderRadius: BorderRadius.circular(
                                    8.0), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.2), // Shadow color
                                    blurRadius: 6, // Blur radius
                                    offset: const Offset(0, 2), // Shadow offset
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Space between icon and text
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/svg/mappin.and.ellipse 1.png', // Icon
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Current location',
                                        style: TextStyle(
                                          color:
                                              Colors.grey, // Label text color
                                          fontSize: 12, // Label text size
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Space between label and value
                                  Text(
                                    currentLocationName, // Value text
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Value text color
                                      fontSize: 14, // Value text size
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),

                // Expanded(
                //   child: TextField(
                //     style: const TextStyle(color: Colors.black),
                //     decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Colors.white,
                //       hintText: 'Enter text here',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: BorderSide.none,
                //       ),
                //       contentPadding:
                //           const EdgeInsets.symmetric(horizontal: 16),
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 10),
                // Circular Button
                SizedBox(width: Get.width * .02),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => FilterOptions(
                        valueNotifier: _valueNotifier,
                        distanceNotifier: _distanceNotifier,
                      ),
                    );
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: AppColors.grey.withOpacity(0.5))
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/svg/filter_icon.svg'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
