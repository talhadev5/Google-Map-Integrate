
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/filter.dart';
import 'package:tophotels/modules/view/map/map_home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool replce = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background Image
          MapHomePage(),
         
          // Overlay content
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Text Field
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // Add custom label with icon and text
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/svg/mappin.and.ellipse 1.png',
                          ), // Replace with desired icon
                          const SizedBox(
                              width: 4), // Space between icon and text
                          const Text(
                            'Current location',
                            style: TextStyle(
                                color: Colors.grey), // Label text style
                          ),
                        ],
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'West House 5th, 3562 New York', // Hint text
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),

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
                      builder: (context) => const FilterOptions(),
                    );
                  },
                  child: Container(
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


